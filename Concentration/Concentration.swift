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
    
    func chooseCard(at index: Int) {
        print("card id [\(index)] and isFaceUp \(cards[index].isFaceUp)", terminator:"" )
//        print("Hello", terminator:"")
        
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
         print("|||||now is FaceUp \(cards[index].isFaceUp)")
    }
    
    //типо стартовый конструктор
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
             let card = Card()
            //we can copy that
//            let matchingCard = card

//            cards.append(card)
            //append same card in our array
//            cards.append(card)
            
            //same thing : add two elem
            cards += [card, card]
        }
        
    }
}
