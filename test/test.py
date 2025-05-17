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
    
suit_values = dict(spades=3, hearts=2, diamonds=1, clubs=0)

def spades_high(card):
    rank_value = FrenchDeck.ranks.index(card.rank)
    return rank_value * len(suit_values) + suit_values[card.suite]

deck = FrenchDeck()
for card in sorted(deck, key=spades_high):
    print(card)