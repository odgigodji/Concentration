//
//  ViewController.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/27/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

import UIKit

//MVC model controller view
//model - our app
//controller - how that presented to the user
//view - controllers's minions
class ViewController: UIViewController {
    //init our class concentration
    //count + 1 / 2 - количество наших карточек
    //lazy - значит что может быть инициализирована но не обязательно использована
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet { //наблюдатель - следит за значением, если что то обновилось
        flipCountLabel.text = "Flips : \(flipCount)"
        }
    }
    
    //надпись внизу
    @IBOutlet weak var flipCountLabel: UILabel!
    
    //типо массив кнопок
    @IBOutlet var cardButtons: [UIButton]!
    
    //actions:_ - имя внешнее аргумента sender - внутреннее имя
    @IBAction func touchCard(_ sender: UIButton) {
//        print("Touch card:")
        flipCount += 1
        //тут мы чекаем не возвращается ли нам нил
        //.firstIndex = Returns the first index where the specified value appears in the collection.
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel() //нужно для оьновления UI - моя функция
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        //.indeces - all indices
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)

            }
        }
    }
    
    var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    var emoji = [Int:String]() //dictionary init

    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex) //удаляем из массива строк  и добавляем в словарь
        }
        
        
        return emoji[card.identifier] ?? "?" //??-check nil
    }
}

