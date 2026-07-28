# Preface
- Từ docs của Python 3.10: “Python is an easy to learn, powerful programming language.”
    - Python dễ học -> nhiều practical user chỉ dùng 1 số tính năng, bỏ qua nhiều tính năng hay của Python.
- Một lập trình viên có kinh nghiệm có thể chỉ cần vài giờ để làm quen với Python. Có xu hướng mang phong cách code python giống code mà trước đây đã làm.
- Có một vấn đề: chúng ta thường chỉ học cái gì chúng ta biết. Ví dụ: mình đã biết về regex. Do vậy mình thường vào trong docs của Python tìm về Regex để đọc.
    - Nhưng unpacking tuple thì mình chưa biết tới bao giờ -> thậm chí còn không bao giờ search về nó -> không biết -> không dùng.
- Trọng tâm cuốn sách: học về những thứ độc đáo của ngôn ngữ Python.
- Cuốn sách dành cho: những người muốn thành thạo Python.
- Cuốn sách không dành cho: những người mới học Python.
- 5 cuốn sách trong 1:
    - Chap 1: ai cũng nên đọc
    - Phần 1 -> 4 là các cuốn sách nhỏ, lồng trong cuốn sách lớn.
    - Chap 2 sẽ focus vào những thứ có sẵn (built-in) trước khi tự xây dựng lại.
    - Tự xây dựng user-defined sequences thì phần 3 mới học. Học cách tận dụng collections.abc thế nào.
    - Cách này có vài ưu điểm:
        - Hiểu rõ cái gì có sẵn -> giảm phát minh cái bánh xe
        - Chúng ta thường sử dụng các collection có sẵn với tần suất nhiều hơn là tự viết
- Cuốn sách này được cấu trúc thế nào?
    - PHần 1: Data structure
        - Chap 1: Giới thiệu về Python Data Model, giải thích tại sao các special methods (VD: __repr__) là chìa khóa dẫn đến sự consistence.
            - Ngoài ra còn cover các collection types: sequences, mapping, sets.
            - Ngoài ra còn str và bytes - niềm vui của người dùng Python 3 và nỗi buồn của người dùng Python 2.
            - Chap này cũng cover high-level class builder của các thư viện chuẩn - named tuple factories và @dataclass decorator
        - Pattern matching - tính năng mới của Python 3.10 cũng được cover ở chap 2, 3, 5
        - Chap cuối của phần này cover life cycle của object: tham chiếu, khả năng thay đổi và trình dọn rác.
    - Phần 2: Function as Object 
        - Nói về việc function là First-class object: có nghĩa là gì? ảnh hưởng thế nào đến các design pattern phổ biến, triển khai decorator bằng việc tận dụng closure.
        - Ngoài ra phần này nói về callable trong Python; function attribute, params, annotation và nonlocal được khai báo trong Python 3.
        - Chap 8 nói về type hints và function signatures
    - Phần 3: Classes và protocols: học để xây dựng class từ đầu, sử dụng abstract base class(ABCs), xử lý đa kế thừa, operator overloading. Sau đó chap 15 lại tiếp tục về type hint.
    - Phần 4: Control Flow
        - Phần này nói về các cấu trúc ngôn ngữ và thư viện vượt ra ngoài flow thông thường với câu điều kiện, vòng lặp, và các chương trình con nữa.
        - Bắt đầu với generator, context manager, corotines, sau đó là yeild from.
        - Chương 18 gồm 1 ví dụ quan trọng với pattern matching (???) - đơn giản mà hiệu quả với trình thông dịch?
        - Chap 19 - giới thiệu về concurrency model trong Python - nói về một cách khác cho concurrent và parallel processing trong Python; hạn chế và cách các kiến trúc phần mềm cho phép Python hoạt động ở quy mô ứng dụng web. 
        - Tác giả viết lại chương async programming, để nhấn mạnh các feature core của ngôn ngữ: await, async dev, async for, async with và mô tả cách nó hoạt động với asyncio và các framework khác.
    - Phần 5: Metaprogramming
        - Phần này ôn lại kĩ thuật xây dựng class - có thể tự động tạo các thuộc tính (attribute) khi chạy chương trình. Việc này hữu ích khi xử lý dữ liệu dạng JSON.
        - Tiếp theo, sách giải thích lại cơ chế property- một tính năng quen thuộc trong Python- rồi đi sâu hơn vào cách Python thực sự đọc và ghi thuộc tính của đối tượng tầng thấp thông qua descriptor.
        - Bạn cũng sẽ hiểu rõ mối quan hệ của function, method và descriptor, cách chúng phối hợp với nhau bên trong Python.
        - Xuyên suốt phần 5, chúng ta sẽ xây dựng 1 thư viện field validator. Trong quá trình đó, nhiều vấn đề tinh vi sẽ xuất hiện, dẫn dắt bạn đến hai công cụ ở chương cuối: 
            - Class decorator - decorator áp dụng cho class,
            - Metaclass - cơ chế cho phép tùy biến cách Python tạo ra class.
## Hands-On approach (Phương pháp học thông qua thực hành)
- Chúng ta sẽ sử dụng Python REPL - interactive console để thực hành.
- Đây là một công cụ học tập cực kì mạnh mẽ.
- Một trong những testing package phổ thông của python là doctest, hoạt động bằng cách giả lập các console session
- Tác giả cũng dùng pytest thay vì thư viện chuẩn unittest vì nó ngon hơn.
- Hầu hết các ví dụ có thể chạy với lệnh `python3 -m doctest example_script.py`

## Soapbox
- Đây là phần cuối mỗi chương, tác giả dùng để so sánh với các ngôn ngữ lập trình khác. 
- Việc này là optional, nếu bạn ko thích, cứ bỏ qua.


# Part 1: Data structures
- Một trong những tính năng hay của Python, là tính thống nhất (consistency).
- Khi quen với Python, bạn thậm chí có thể đoán được cả những tính năng mà bạn chưa biết đến.
- Nếu bạn đã quen với OOP, có thể bạn cảm thấy hơi lạ với cú pháp len(arr) thay vì arr.length. Khi hiểu sâu hơn, bạn sẽ thấy đây là cách mà Python khéo léo sử dụng các feature của ngôn ngữ, gọi là Python Data Model.

## Chap 1: The Python Data model
- Cùng đến với ví dụ:
```python
import collections

Card = collections.namedtuple('Card', ['rank', 'suite'])

class FrenchDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suites = 'spades diamonds clubs hearts'.split()

    def __init__(self):
        self._cards = [Card(rank, suite) for suite in self.suites
                                        for rank in self.ranks]
    
    def __len__(self):
        return len(self._cards)

    def __getitem__(self, position):
        return self._cards[position]
```
- Class FrenchDeck khá đầy đủ tính năng.
- Nếu cần pick random card, không cần code thêm gì cả:
```python
from random import choice

deck = FrenchDeck()
choice(deck)
```

- Ta có thể thấy hai lợi ích của special methods để tận dụng Python Data Model:
    - Người dùng không cần nhớ các methods cho standard operation (VD lấy length, không cần nhớ là .size, .length hay . gì đó)
    - Dễ dàng dùng lại các method từ Python, không cần viết lại các hàm có sẵn (ví dụ random.choice)

- Dựa vào __getitem__, ta có thể truy xuất deck như một mảng:
```python
deck[:3]
deck[12::13]
```
- Hoặc vòng lặp:
```python
for card in deck:
    print(card)

for card in reversed(deck):
    print(card)
```

- Để kiểm tra object có nằm trong deck không cũng rất đơn giản
```python
>>> Card('Q', 'hearts') in deck
True
```

- Sorting cũng ez luôn:
```python
suit_values = dict(spades=3, hearts=2, diaminds=1, clubs=0)

def spades_high(card):
    rank_value = FrenchDeck.ranks.index(card.rank)
    return rank_value * len(suit_values) + suit_values[card.suit]
```

- Bằng việc implement 2 special method: __len__ và __getitem__, FrenchDeck có behaviour giống như một standard Python sequence, cho phép sử dụng các tính năng của core language feature (iteration, slicing)

- Còn shuffling thì sao? FrenchDeck không thể shuffled được, vì nó là `immutable`. Trong chap 13, chúng ta sẽ thêm __setitem__ method để fix nó.

### Special methods được sử dụng thế nào?
- Điều đầu tiên nên biết về special method: nó được gọi bởi Python, không phải bạn. Bạn không cần viết my_object.__len__(). Bạn chỉ cần viết len(my_object), Python sẽ gọi hàm __len__ mà bạn implement.
- Python variable-sized collection (list, str, bytearray hoặc extension như NumPy arrays) được viết bởi C, bao gồm một cái struct gọi là PyVarObject, sẽ có 1 field gọi là ob_size, chứa số lượng item của collection.
    - Vì thế mà nếu my_object mà là instance của kiểu variable-sized collection thì khi gọi hàm len(my_object) sẽ trả về giá trị của ob_size field, và việc này sẽ nhanh hơn là call method.
- Special method call là không tường minh. Ví dụ; khi bạn gọi `for i in x`:
    - Nó sẽ invoke iter(x)
    - Và sẽ chuyển thành gọi x.__iter__()
    - Hoặc gọi x.__getitem__()

- Thông thường thì chúng ta không nên gọi thẳng vào special methods, trừ hàm __init__ để gọi ở hàm tạo ra.


#### Emulating enumric types

```python
import math

class Vector:
    def __init__(self, x=0, y=0):
        self.x = x
        self.y = y
    
    def __repr__(self):
        return f'Vector({self.x!r}), {self.y!r})'
    
    def __abs__(self):
        return math.hypot(self.x, self.y)

    def __bool__(self):
        return bool(abs(self))

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return Vector(x, y)
    
    def __mul__(self, scalar):
        return Vector(self.x * scalar, self.y * scalar)
```

- Trong này có 5  special method.
- Nhìn 2 phép __add__ và __mul__ để thấy implementation khá đơn giản.
- Và trong cả 2 trường hợp cộng và nhân, chúng ta đều trả về một instance mới của vector mà không động vào 2 toán hạng.
    - Trong này, chúng ta đang nhân vector với số, không nhân được số với vector. Ở chương 16, ta sẽ fix việc này với __rmul__

#### String representation
- __repr__ special method được gọi bởi repr built in trong Python để get ra string representation. Nếu không có hàm __repr__ custom này, Python sẽ in ra <Vector object at  0x10e10070>
- Console sẽ gọi hàm repr với các đoạn code được chạy, và sử dụng %r placeholder (cái này hơi rắc rối tí, nhưng đại khái !r sẽ là để format string khi dùng f-string)
- __str__ được gọi bởi str() built-in và không tường minh. Bạn không cần code thêm hàm __str__ vì đối với object, sẽ call __repr__ như một fallback.
- Đoạn này hơi lú, nhưng đại khái thì:
    - Nên implement __repr__  vì nó là defalt.
    - __repr__ nó giống kiểu type để có thể gọi hàm tạo được, machine readable
    - __str__ thì giống kiểu để người dùng dễ đọc, human readble

#### Boolean value of a custom type
- Kiểu bool để xác định xem object là True hay False, dùng trong mệnh đề điều kiện hay các toán tử and, or.
- Mặc định thì các instance của user-defined class sẽ được coi là True, trừ khi được định nghĩa __bool__ hoặc __len__:
    - bool(x) sẽ gọi x.__bool__()
    - Nếu không có, sẽ gọi x.__len__()
    - Nếu ko có => trả về True
- Ở ví dụ trong bài:
```python
    def __bool__(self):
        return bool(abs(self))
```
- Cách này thì cũng được, nhưng nó sẽ mất round trip (tức là tốn công hơn) do gọi thêm hàm abs. Có cách đơn giản và chạy nhanh hơn:
```python
    def __bool__(self):
        return bool(self.x or self.y)
```

#### Collection API
