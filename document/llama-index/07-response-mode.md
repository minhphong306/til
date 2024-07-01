- Bài này nói về 5 thuật tóan dùng trong Response mode: compact, refine, tree_summarize, accumulation, simple_summarize
- Để dễ hiểu thì trong bài sẽ dùng ví dụ:
    - Câu hỏi: "Ai bắn tổng thống John F.Kennedy?"
    - Tài liệu input dài 250000 words, là một cái báo cáo.
    - Tài liệu này dài hơn context length của GPT-4 nên không feed toàn bộ tài liệu vào context được.

# LLama Index Response Mode là gì?
- Sau step retrieval, lấy được về các chunks
- Chunks vẫn quá lớn, không thể feed thẳng vào prompt được.
- Tách ra thành nhiều lần gọi sang LLM theo thứ tự, để lấy được câu trả lời duy nhất.

# Testing method
- Sử dụng OpenAI's GPT-4 LLM
- Sử dụng BAAI/bge-small-env-v.16 embbedding model
- Sử dụng PromptLayer để log ra tòan bộ prompt gửi và nhận từ LLM
- Một bản copy của Warren Commission Report đuợc tạo ra.
- Một self-hosted vector database bao gồm 853 vectors, thể hiện warrent report; chia thành 5 chunks
- Với mỗi test, sử dụng cùng câu hỏi: "Những kết luận chính của báo cáo vụ ám sát tổng thông Kennedy là gì?"
- Dưới đây là Python code sử dụng để evalute mỗi response mode, ví dụ dưới đang sử dụng `compact` mode.

```python
import os.path
from llama_index.core import (
    VectorStoreIndex,
    SimpleDirectoryReader,
    StorageContext,
    load_index_from_storage,
    ServiceContext,
    set_global_handler,
    Settings
)

from llama_index.vector_stores.milvus import MilvusVectorStore
from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.llms.openai import OpenAI

# Set the global handler to print to stdout
set_global_handler("promptlayer",pl_tags=["warrenreport"])
Settings.llm = OpenAI(temperature=0.7,model="gpt-4")
Settings.embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-small-en-v1.5")

#load index from existing vector store
vector_store = MilvusVectorStore(dim=1536,uri="http://x.x.x.x:19530", collection_name="warrenreport",token="xxxx:xxxxx")
storage_context = StorageContext.from_defaults(vector_store=vector_store)
index = VectorStoreIndex.from_vector_store(vector_store,storage_context=storage_context)

query_engine = index.as_query_engine(response_mode="compact",similarity_top_k=5)
response = query_engine.query("query_engine = index.as_query_engine(response_mode="compact",similarity_top_k=5)
response = query_engine.query("What are the main conclusions of the Warren Report regarding the assassination of President Kennedy?")")
```

# Compact
- Compact là mode mặc định sử dụng LlamaIndex.
- Cách hoạt động: gom các chunks lại thành to nhất có thể.
- Trong ví dụ này, context to nhất là 4 chunks -> cần 2 LLM calls.
- Call đầu tiên dùng `compact` response mode, sử dụng `text_qa_template` prompt

```txt
Context information is below.
---------------------
file_path: blog-data/warren-report.txt

<Concatenation of Chunk 1...4>

--------------------
Given the context information and not prior knowledge, answer the query.
Query: What are the main conclusions of the Warren Report regarding the assassination of President Kennedy?
Answer:
```

- Llama index lấy câu trả lời về, đưa vào prompt tiếp theo, sử dụng `refine_template` prompt:

```txt
You are an expert Q&A system that strictly operates in two modes when refining existing answers:
1. Rewrite an original answer using the new context.
2. Repeat the original answer if the new context isn't useful.
Never reference the original answer or context directly in your answer.
When in doubt, just repeat the original answer.

New Context:

<Last X Characters of Chunk 4>

file_path: blog-data/warren-report.txt

<Chunk 5>

Query: What are the main conclusions of the Warren Report regarding the assassination of President Kennedy?
Original Answer: The main conclusions of the Warren Report regarding the assassination of President Kennedy are not explicitly listed in the provided context. The Warren Report was created to provide full and truthful knowledge concerning the events surrounding the assassination, and to appraise this tragedy by the light of reason and the standard of fairness. The context mentions that the report was prepared with a deep awareness of the Commission’s responsibility to present an objective report of the facts to the American people. However, the specific conclusions of the report are not provided in the context.
New Answer:

```

## Compact "answer"
- Như bạn đã thấy, `compact` response mode không trả lời câu hỏi một cách mạch lạc.
- Lí do: 4 chunks đầu không có thông tin về kết luận vụ ám sát tổng thống Kenedy.
    - Chunk cuối mới có kết luận. Dù chunk cuối có cosin similarity score thấp hơn chunks trước đó.
- Thus, the structure of the refine_template is such that if the first set of calls has gone down the wrong path, it’s difficult for the final prompt to steer the LLM back onto the right track.?

# Refine
- Mode thứ 2 là Refine.
- Mode này mỗi lần gửi 1 chunks đi, lấy kết quả trả lời và sử dụng refine_template để lấy ra kết quả tiếp theo.
    - lần 1: text_qa_template -> response
    - lần 2: refine_template
    - lần n-1: refine_template
    - lần n: refine_template -> final answer.

# Tree Summarize
