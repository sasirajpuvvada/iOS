//
//  HistoryDetailsVC.swift
//  Trivia App
//
//  Created by Sasi Raj on 10/05/20.
//

import UIKit

class HistoryDetailsVC: UIViewController {

    @IBOutlet weak var game: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var cricAnswer: UILabel!
    @IBOutlet weak var flagColors: UILabel!
    var nameStr = ""
    var gameStr = ""
    var cricName = ""
    var flagName = ""
    var count = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        game.text = "Game: \(count) \(gameStr)"
        name.text = "Name : \(nameStr)"
        cricAnswer.text = cricName
        flagColors.text = flagName
    }
    
}
