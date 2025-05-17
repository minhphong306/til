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
