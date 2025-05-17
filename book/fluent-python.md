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
- 