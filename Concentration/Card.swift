//
//  Card.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/31/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

//model not UI
import Foundation

//no inheritance in struct
//structs are value types
struct Card {
    var isFaceUp = false  //перевернута
    var isMatched = false //совпала
    var identifier: Int
    
    //i - internal name
    //identifier - external name

//    init(identifier i: Int) {
//        identifier = i
//    }
    
    static var identifierFactory = 0
    
    //static func is
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    //self. - fix
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
