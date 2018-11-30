//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var gameBrain = HangmanBrain()
    @IBOutlet weak var cohortInputTextField: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var hangManImage: UIImageView!
    
    @IBAction func newGame(_ sender: UIButton) {
        gameBrain = HangmanBrain()
        userInputTextField.text = ""
        cohortInputTextField.text = ""
        guessLabel.text = "User One please enter a Word!"
        wordLabel.text = ""
        imageSwitch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userInputTextField.delegate = self
        cohortInputTextField.delegate = self
    }
    fileprivate func imageSwitch() {
        let imageStr = "hang\(7 - gameBrain.guessCount)"
        hangManImage.image = UIImage(named: imageStr)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleTextFieldReturned(textField: textField)
        return true
    }
    
    func handlUserGuess(with guess: String?) {
        if let playerTwoInput = guess {
            switch gameBrain.guessStatus(from: playerTwoInput) {
            case .alreadyGuessed:
                guessLabel.text = "Used the letter \(playerTwoInput) already."
                return
            case .invalidLetter:
                guessLabel.text = "That's not a valid letter!"
                return
            case .valid, .outOfGuesses: break
            }
            switch gameBrain.update(with: playerTwoInput) {
            case .inProgess:
                wordLabel.text = gameBrain.guessedLetterDisplayText
                guessLabel.text = "You still have \(gameBrain.guessCount) chances left!"
                imageSwitch()
            case .victory:
                wordLabel.text = "You Win. Word: \(userInputTextField.text!)"
            case .defeat:
                wordLabel.text = "You Lose. Word: \(userInputTextField.text!)"
            }
        }
    }
    
    func setHiddenWord(to word: String) {
        gameBrain.setHiddenWord(to: word)
        wordLabel.text = gameBrain.guessedLetterDisplayText
    }
}

extension ViewController: UITextFieldDelegate {
    
    func handleTextFieldReturned(textField: UITextField) {
        imageSwitch()
        switch textField {
        case cohortInputTextField:
            handlUserGuess(with: textField.text?.uppercased())
        case userInputTextField:
            setHiddenWord(to: textField.text!)
        default: fatalError("Unexpected text field")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
