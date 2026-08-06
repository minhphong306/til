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

## Conventions
- Chữ nghiêng: terms, URLs, email, filename hoặc file extension

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
    suits = 'spades diamonds clubs hearts'.split()

    def __init__(self):
        self._cards = [
            Card(rank, suit)
            for rank in self.ranks
            for suit in self.suits
        ]

    def __len__(self):
        return len(self._cards)

    def __getitem__(self, key):
        return self._cards[key]
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
- Trình biên dịch có một đường tắt với các built-in types (list, str, bytearray,...): có một thuộc tính lưu lại kích thước của type này.
    - Khi gọi len(my_object) -> trả thẳng về giá trị từ thuộc tính mà ko cần gọi hàm -> nhanh hơn
- Special method call là không tường minh. Ví dụ; khi bạn gọi `for i in x`:
    - Nó sẽ invoke `iter(x)`
    - Và sẽ chuyển thành gọi `x.__iter__()`
    - Hoặc gọi x.__getitem__()

- Thông thường thì chúng ta không nên gọi thẳng vào special methods, trừ hàm __init__ để gọi ở hàm tạo ra.
- Khi mình gọi các hàm built in kiểu len, iter, str,... thì thực ra vẫn sẽ gọi special methods thôi. Nhưng trong 1 số trường hợp có ngách chó thì sẽ đi nhanh hơn.
- Trong section tiếp theo, chúng ta sẽ thấy một số use case của special methods:
    - Emulating numeric type -> làm đối tượng hoạt động giống như một số, hỗ trợ +, -, *, /
    - String representation (biểu diễn dạng chuỗi)
    - Boolean value
    - Implementing collection


#### Emulating enumric types
- Đoạn này lấy ví dụ về vector.
- Một tí kiến thức:
    - Cộng 2 vector: cộng giá trị x, y tương ứng
    - Độ lớn (magnitude) của vector: |v| = căn (x2 + y2)
    - Phép nhân: nhân x, y của vector với số nhân

```python
import math

class Vector:
    def __init__(self, x=0, y=0)
        self.x = x
        self.y = y

    def __abs__(self):
        return math.hypot(self.x, self.y)

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y)

    def __mul__(self, scalar):
        return Vector(self.x*scalar, self.y*scalar)

    def __bool__(self):
        return bool(abs(self))

    def __repr__(self):
        return f'Vector({self.x!r}, {self.y!r})'
```

- Trong này có 5  special method. Có thể thấy là chúng ta ko tự call special method này trong class. Chỉ có Python interpreter tự call thôi
- Nhìn 2 phép __add__ và __mul__ để thấy implementation khá đơn giản.
- Và trong cả 2 trường hợp cộng và nhân, chúng ta đều trả về một instance mới của vector mà không động vào 2 toán hạng.
    - Đây là behaviour mong muốn với toán tử infix - chương 16 sẽ nói nhiều hơn.
- Trong này, chúng ta đang nhân vector với số, không nhân được số với vector. Ở chương 16, ta sẽ fix việc này với __rmul__

#### String representation
- __repr__ được gọi bởi repr built-in để lấy string biểu diễn object.
- Mặc định thì __repr__ sẽ in ra một đối tượng ở địa chỉ bao nhiêu, trông như này: `<Vector object at 0x10e100070>`
- Để ý cú pháp `!r` thì là cái để **giữ nguyên format**.
    - Ví dụ cụ thể thì:
        - Ko có `!r`: Vector("a", "b") sẽ in ra `Vector(a, b)`
        - Có `!r`: Vector("a", "b") sẽ in ra `Vector('a', 'b')`
    - => nên dùng `!r` cho nó tường minh. Và ý nghĩa của `__repr__` thực chất là: copy ra có thể chạy luôn được.
- Có 1 bài khá hay trên [Stackoverflow](https://stackoverflow.com/questions/1436703/what-is-the-difference-between-str-and-repr) về chủ đề 2 thằng str và repr khác nhau thế nào. Ngắn gọn thì là:
    - __repr__: dành cho các ông lập trình viên debug. Copy cái output vào code chạy đc luôn (eval(repr(vector1)))
    -__str__: dành cho người dùng cuối, nhìn 1 string được format đẹp đẽ dễ nhìn.
    - Nếu chỉ được chọn implement 1 hàm => chọn thằng repr, vì str nó sẽ fallback về repr

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
- Abstract Base Classes (ABCs) thì có:
    - Reversible
    - Iterable
    - Sized
    - Container
    - Sequence
    - Mapping
    - Set
- Trong mỗi thằng sẽ có một số lượng special method, chia làm 3 nhóm:
    - Iterable: support vòng lặp for, unpacking, hoặc các kiểu lặp
    - Sized: hỗ trợ len built-in function
    - Container: support in operation
- Python ko yêu cầu các class implement các Abstract based class này tường minh.
    - VD: Bất cứ class nào implement __len__ thì đều thỏa mãn Sized interface.
- Chia các collection quan trọng ra thành 3 nhóm:
    - Sequence: list, str
    - Mapping: dict, collection.defautdict
    - Set: set, frozenset
- Chỉ có Sequence thì support reversed, vì nó có thứ tự
    - Thiệt ra từ python 3.7, dict cũng support thứ tự, nhưng mà cũng ko chuẩn lắm đâu.
- Infix operator: toán tử nằm giữa 2 toán hạng
    - VD: `a & b`
- Tất cả các special method trong Python là infix operator

### Overview về special methods

// TODO: fill SOAPBOX chap 1

## Chap 2: An Array of Sequences
- Trước khi tạo ra Python, Guido contribute 10 năm ở ngôn ngữ ABC
- ABC có rất nhiều ý tưởng mà ta gọi là Pythonic: 
    - Các thao tác dùng chung cho nhiều kiểu chuỗi (VD: len dùng đc cả list, tuple, string)
    - Kiểu tuple có sẵn
    - Structure bằng cách thụt đầu dòng, không dùng ngoặc nhọn
    - Vẫn strong type mà không cần khai báo kiểu dữ liệu
- Không phải ngẫu nhiên mà Python lại thân thiện với người dùng đến vậy
- Python kế thừa từ ABC cách xử lý thống nhất với với các chuỗi (sequences).
    - str, list, bytes, array; xml, kết quả truy vấn CSDL đều dùng chung các hàm iteration, slicing, sorting, concat
- Hiểu rõ sự đa dạng của kiểu chuỗi có sẵn, giúp ta khỏi phát minh lại bánh xe. Với sau mà thiết kế cái gì thì sẽ có 1 cái tư duy tốt hơn để thiết kế những cái dùng chung.
- CHương này nói về kiểu sequences: str, list, bytes, array, queue
- Chương 4 nói về  Unicode, byte
- Chương này chủ yếu nói về kiểu chuỗi có sẵn để dùng ngay.
- Chương 12: tự tạo kiểu chuỗi của riêng bạn.

- Một số topic mà chương này sẽ cover:
    - List comprehension và basic của generator expressions
    - Sử dụng tuples như records và tuples như immutable lists
    - Sequences unpacking và sequences pattern
    - Đọc và ghi vào slice
    - Một số loại sequences đặc biệt: array, queues.

### Overview of built-in sequences
- Các loại sequences (implement từ C):
    - Container sequences: có thể chứa items từ nhiều type, có thể chứa cả nested container: list, tuple, collections.deque
    - Flat sequences: chứa item simple type: str, bytes, array.array
        - Note:
            - Container sequences thì mỗi phần tử sẽ lưu một reference tới 1 flat sequences
- Một cách khác để phân loại: theo sự "có thể thay đổi":
    - Mutable sequences: list, bytearray, array.array, collections.dequeue
    - Immutable sequences: tuple, str, byte
- Hãy nhớ đặc điểm chung: mutable & immutable; container & flat. Việc này giúp bạn suy rộng ra, từ một kiểu ra các kiểu còn lại.
- Kiểu `list` là một kiểu nền tảng, list comprehension cũng là 1 cú pháp quan trọng.

```python
from collections import abc
issubclass(tuple, abc.Sequence) # True
issubclass(list, abc.MutableSequence) # False
```

### List comprehension & Generator Expression
- list comprehension và generator expression là cách để build 1 list tiện lợi & nhanh & dễ đọc.
    - Thường viết tắt:
        - List comprehension = listcomps
        - Generator expression = genexps

#### Tính dễ đọc của listcomps
- Kiểu loop thông thường:
```python
symbols = "Hello Viet Nam"
codes = []

for symbol in symbols:
    codes.append(ord(symbol))

print(codes)
```
- Kiểu loop với list comprehension

```python3
symbols = "Hello Viet Nam"
codes = [ord(symbol) for symbol in symbols]
```
- Lưu ý quan trọng: KHÔNG LẠM DỤNG listcomps
    - listcomps chỉ dùng để build list.
    - Nếu code của bạn không build list thì đừng dùng.
    - Vòng for trong listcomps nên đơn giản.

#### Local scope với listcomps và generator expression
- Nghĩa là thường thì biến tạm trong listcomps ra ngoài ngoặc vuông là biến mất.
- Với cú pháp hải mã (:=) thì ra ngoài vẫn còn.

```python
symbol = "Hello"
codes = [ord(s) for s in symbol] # s ra ngoài vòng lặp biến mất

codes = [last := ord(s) for s in symbol] # ra ngoài vòng lặp, last vẫn truy cập được
print(last) # o
```
- listcomps thì dùng để build list, transform item.
    - filter và map cũng làm điều tương tự, mà hơi khác 1 tí -> xem phần tiếp

#### listcomps vs map vs filter
- Ví dụ dùng listcomps
```python
symbols = "Hello VIET NAM"
lowers = [ord(s) for s in symbols if ord(s) > 97]
```
- Ví dụ dùng map & filter

```python
symbols = "Hello Viet Nam"
lowers = list(filter(lambda c: c > 97, map(ord, symbols)))
```
- Ban đầu thì tác giả tin rằng: listcomps có vẻ nhanh hơn. Nhưng mà không phải vậy. Có vẻ same same.

```python
import timeit

TIMES = 10000
SETUP = """
symbols = '$¢£¥€¤'
def non_ascii(c):
    return c > 127
"""

def clock(label, cmd):
    res = timeit.repeat(cmd, setup=SETUP, number=TIMES)
    print(label, *(f'{x:.3f}' for x in res))

clock('listcomps            :', '[ord(s) for s in symbols if ord(s) > 127]')
clock('listcomps + func    :', '[ord(s) for s in symbols if non_ascii(s)]')
clock('filter + lambda      :', 'list(filter(lambda c: c > 127, map(ord, symbols)))')
clock('filter + func', 'list(filter(non_ascii, map(ord, symbols)))')
```

#### Tích đề các (cartasian products)
- Đại khái giống kiểu build tổ hợp
```python
sizes = ['S', 'M', 'L']
colors = ['red', 'blue', 'green']

tshirts = [
    (color, size)
    for color in colors
    for size in sizes
]
```
#### Generator expression
- Generator expression đỡ tốn mem hơn, vì không lưu toàn bộ array vào bộ nhớ.
- Cứ vòng lặp chạy đến đâu thì phần tử mới sinh ra đến đó
- Nó gần giống listcomps:
    - Listcomps: dùng ngoặc vuông: `[]`
    - Genexps: dùng ngoặc tròn: `()`
- Ví dụ dùng genexps:
```python
colors = ['Red', 'Green', 'Blue']
sizes = ['S', 'M', 'L']

for tshirt in (f'{c} {s}' for color in colors for size in sizes)
    print(tshirt)
```

### Tuple không chỉ là một immutable list
- Tuple có hai cách sử dụng: immutable list và record không có field name
#### Tuple as a record

```python
lax_coordinates = (100, 100)
city, year, pop = ('Ha Noi', 2010, 100)
traveler_ids = [('VNA', 100), ('USA', 200), ('FRA', 300)]

for passport in traveler_ids:
    print('%s %s' % passport)

for country, _ in traveler_ids:
    print(country)
```

#### Tuple as immutable list
- Tuple sử dụng ít bộ nhớ hơn list - cùng độ dài

### Unpacking sequences và iterable
- Unpacking là qua trọng và cần thiết, vì tránh lãng phí các biến không sử dụng.
- Ngoài sequences ra, Unpacking còn hoạt động với các biến iterable (bình thường iterable không truy cập được qua [] nhé)

// TODO: fill this section

### Pattern matching Sequences trong Intepreter
