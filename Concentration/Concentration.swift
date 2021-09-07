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
    var cards = [Card]() //u can get but not set

    var numbersOfPairsOfCards = 0
//    var indexOfOneAndOnlyFaceUpCard: Int? //old version
    
    //computed properties
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            //calculate value depend on class member and logic
            var foundIndex: Int? // = nil for default
            for index in cards.indices {
                if cards[index].isFaceUp { //found a faceup card
                    if foundIndex == nil { //found first one
                        foundIndex = index
                    } else { return nil } //i found second faceup card
                }
            }
            print("foundIndex is \(String(describing: foundIndex))")
            return foundIndex
        }
        set(newValue) { //we can dont write "newValue" - default it is // just "set"
            print("newValue is \(String(describing: newValue))")
            for index in cards.indices { //go throug all cards while not
                     cards[index].isFaceUp = (index == newValue) //its bool
            }
        }
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concerntration.chooseCard(at: \(index) : chosen index not in the cards")
        if !cards[index].isMatched {
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
//                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                
//                //either no cards or 2 cards are face up
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
