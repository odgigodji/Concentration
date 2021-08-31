//
//  ViewController.swift
//  Concentration
//
//  Created by Nelson Amerei on 8/27/21.
//  Copyright © 2021 School21 namerei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0
    //    var flipCount: Int = 0 same
    
    //надпись внизу
    @IBOutlet weak var flipCountLabel: UILabel! //!это на след урок
    
    
    //_ - имя внешнее аргумента sender - внутреннее имя
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        flipCountLabel.text = "Flips : \(flipCount)"
        flipCard(withEmoji: "👻", on: sender)
//        print("a ghost!")
    }
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCount += 1
        flipCountLabel.text = "Flips : \(flipCount)"
        flipCard(withEmoji: "🎃", on: sender)
//        print("a pumpkin!")
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
//        print("flipCard \(emoji)")
        if button.currentTitle == emoji { //current title
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

