//
//  Concentration.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/31/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

import Foundation

struct Concentration {
    var cards = [Card]()

    var numbersOfPairsOfCards = 0

    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else { return nil }
                }
            }
            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                     cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concerntration.chooseCard(at: \(index) : chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    numbersOfPairsOfCards -= 1
                    
                    if numbersOfPairsOfCards == 0 {
                        print("game over")
                        return
                    }
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
             let card = Card()
            cards += [card, card]
            cards.shuffle()
        }
        if numberOfPairsOfCards > 0 {
            self.numbersOfPairsOfCards = numberOfPairsOfCards
        }
    }
}
