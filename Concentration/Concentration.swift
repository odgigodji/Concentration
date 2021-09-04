//
//  Concentration.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/31/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

//model file totaly ui independent
import Foundation

//classes are reference types
class Concentration {
    //API design
//    var cards: Array<Card>
//    var cards = Array<Card>()
    var cards = [Card]()

    var numbersOfPairsOfCards = 0
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {

        if !cards[index].isMatched {
//            print("card index is [\(index)] ", terminator: "")
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    //cards is matched
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    numbersOfPairsOfCards -= 1
                    if numbersOfPairsOfCards == 0 {
                        print("game over")
                        return
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = index
            }
        }
        print("numbOfPairs is \(self.numbersOfPairsOfCards)")
    }
    //button with new game
    
    
    //типо стартовый конструктор
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
             let card = Card()
            //we can copy that
//            let matchingCard = card

//            cards.append(card)
            //append same card in our array
//            cards.append(card)
            
            //same thing : add two elem
            cards += [card, card]
            
            //TODO: SHUFFLE THE CARDS
            cards.shuffle()
        }
        if numberOfPairsOfCards > 0 {
            self.numbersOfPairsOfCards = numberOfPairsOfCards
        }
        print("numbOfPairs is \(self.numbersOfPairsOfCards)")
    }
    
}
