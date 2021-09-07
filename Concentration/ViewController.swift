//
//  ViewController.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/27/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

import UIKit
import MapKit

//MVC model controller view
//model - our app
//controller - how that presented to the user
//view - controllers's minions
class ViewController: UIViewController {
    //init our class concentration
    //count + 1 / 2 - количество наших карточек
    
    //lazy - значит что может быть инициализирована но не обязательно использована
//    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { //read only computed property
//        get {
            return (cardButtons.count + 1) / 2
//        }
    }
    
    private(set) var flipCount = 0 { //private for set
        didSet { //наблюдатель - следит за значением, если что то обновилось
        flipCountLabel.text = "Flips : \(flipCount)"
        }
    }
    
    //надпись внизу
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    //типо массив кнопок
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGame(_ sender: UIButton) {
        print("new game")
    }
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    //actions:_ - имя внешнее аргумента sender - внутреннее имя
    @IBAction private func touchCard(_ sender: UIButton) {
//        print("Touch card:")
        flipCount += 1
        //тут мы чекаем не возвращается ли нам нил
        //.firstIndex = Returns the first index where the specified value appears in the collection.
        print("count \(cardButtons.count)")
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel() //нужно для оьновления UI - моя функция
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        for id in 0..<game.cards.count {
            game.cards[id].isFaceUp = false
            game.cards[id].isMatched = false
            cardButtons[id].setTitle("", for: UIControl.State.normal)
            cardButtons[id].backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
        game.numbersOfPairsOfCards = (cardButtons.count + 1) / 2
        cardButtons.shuffle()
        newGameButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        newGameButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        newGameButton.setTitle("Reset", for: UIControl.State.normal)
        flipCount = 0
    }
    
    private func updateViewFromModel() {
        //.indeces - all indices
        if game.numbersOfPairsOfCards == 0 {
           newGameButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
           newGameButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
            newGameButton.setTitle("New game", for: UIControl.State.normal)
        }
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if card.isMatched {
                    button.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0)
                } else {
                    button.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    private var emoji = [Int:String]() //dictionary init

    //MARK: handle card touch behavior

    private func emoji(for card: Card) -> String {
//        print("emoji func: \(Card.identifierFactory)")
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count))) //используем extension для рандомного присвоения карточек
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random) //удаляем из массива строк  и добавляем в словарь
        }
        return emoji[card.identifier] ?? "?" //??-check nil
    }
    
}

extension Int { // расширение для Int
    var arc4random: Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else { return 0 }
    }
}


//-------------------------------test section-------------------------------------------------
    
//-------------------------enums //data types-------------------------
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, liter: Double) // associate value
    case cookie
    
    //enums can have method
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
        case .hamburger(let pattyCount): return pattyCount == number
        case .fries, .cookie: return true
        case .drink(_, let liter): return liter == 0.5 //return true if liter == 0.5
        }
    }
    
    //modifiing yourself
    mutating func switchToBeingACookie() { //value type - copy on write
        self = .cookie //this work if self is a .hamburger of frie or etc
    }
    var calories: Int { return 100 }
}

enum FryOrderSize {
    case large
    case small
}

//let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)
var otherItem2: FastFoodMenuItem = .cookie
var otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
var otherItem1 = FastFoodMenuItem.hamburger(numberOfPatties: 2)
var Item = FastFoodMenuItem.fries

//func test() {
    var menuItem  = FastFoodMenuItem.hamburger(numberOfPatties: 2)
//
//    switch menuItem {
//    case .hamburger: print("burger")
//    case .fries: print("fries")
                //print("yammy")
////      case .drink: print("drink")
////      case .cookie: print("cookie")
//    default: print("other")
//    }
//
//}

//switch menuItem {
//case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties")
//}

//---------------------------------optionals---------------- //opitonals its enums
//enum Optional<T> {
//    case none         //nil
//    case some(<T>) //value
//}

class Test {
    var hello: String?              //var hello: Optional<String> = .none
    var hello1: String? = "helloo"  //var hello1: Optional<String> = .some("helloo")
    var hello2: String? = nil       //var hello2: Optional<String> = .none
    
    func test() {
        var someNumber: Int?
        someNumber = 3
        //Force unwrap
        //    print(someNumber!) - error without value. use only with value
        
        //if let
        
        if let number  = someNumber {
            print(number)
        } else {
            print("there is no number")
        }
        
        //Nil-Coalescing operator //оператор объединения по nil
        
        print(someNumber ?? 1234)
        
        //guard
        
        func multiplyByTwo(number: Int?) {
            guard let guardNumber = number else {
                print("there is nil")
                return
            }
            print("\(guardNumber) x 2 = \(guardNumber * 2)")
        }
        
        //Optional chaining
        struct iPhone {
            var model: String
            var memory: Int
            var color: String
        }
        var myIphone: iPhone?
        myIphone = iPhone(model: "Iphone 7", memory: 128, color: "black")
        
        let deviceColor = myIphone?.color // deviceColor is auto optional
        
        if let phoneColor = deviceColor {
            print("the color is \(phoneColor)")
        }
        
    }
}

//memory management-----------
//strong: keep that thing in the heap as long as this is around(default)
//weak: if thats reference goes - set to nil
//enownde: "don't reference count this; crash if i'm wrong"
