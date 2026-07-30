import collections

Card = collections.namedtuple('Card', ['rank', 'suite'])

class FrendDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suites = 'spades diamonds clubs hearts'.split()

    def __init__(self):
        self._cards = [Card(rank, suite) for suite in self.suites
                                        for rank in self.ranks]
        
        def __len__(self):
            return len(self._cards)

        def __getitem__(self, position):
            return self._cards[position]