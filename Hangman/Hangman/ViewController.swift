//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var guessCount = 6
    var storedUserInput = [String]()
    var userCorrectLetters: [String] = []
    @IBOutlet weak var cohortInputTextField: UITextField!
    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var hangManImage: UIImageView!
    
    @IBAction func newGame(_ sender: UIButton) {
        guessCount = 6
        storedUserInput = [String]()
        userCorrectLetters = []
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
}


extension ViewController: UITextFieldDelegate {
    
    fileprivate func imageSwitch() {
        switch guessCount {
        case 6:
            hangManImage.image = UIImage(named: "hang1")
        case 5:
            hangManImage.image = UIImage(named: "hang2")
        case 4:
            hangManImage.image = UIImage(named: "hang3")
        case 3:
            hangManImage.image = UIImage(named: "hang4")
        case 2:
            hangManImage.image = UIImage(named: "hang5")
        case 1:
            hangManImage.image = UIImage(named: "hang6")
        case 0:
            hangManImage.image = UIImage(named: "hang7")
        default:
            print("nothing")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        imageSwitch()
        if cohortInputTextField.text != "" {
            while guessCount > 0{
                if let playerTwoInput = cohortInputTextField.text?.uppercased(){
                    guard alphabet.contains(playerTwoInput)  else {
                        guessLabel.text = "That's not a valid letter!"
                        return true
                    }
                    
                    guard !storedUserInput.contains(playerTwoInput) else {
                        guessLabel.text = "Used the letter \(playerTwoInput) already."
                        return true
                    }
                    
                    storedUserInput.append(playerTwoInput)
                    
                    if userInputTextField.text!.contains(playerTwoInput){
                        for (index, char) in userInputTextField.text!.enumerated() {
                            if String(char) == playerTwoInput {
                                userCorrectLetters[index] = playerTwoInput
                                wordLabel.text = userCorrectLetters.joined(separator: " ")
                            }
                        }
                        
                        guessLabel.text = "You still have \(guessCount) chances left!"
                    } else {
                        
                        guessCount -= 1
                        imageSwitch()
                        guessLabel.text = "You have \(guessCount) chances left!"
                    }
                }
                if !userCorrectLetters.contains("_") {
                    wordLabel.text = "You Win. Word: \(userInputTextField.text!)"
                    
                }
                if guessCount == 0  {
                    wordLabel.text = "You Lose. Word: \(userInputTextField.text!)"
                }
                return true
            }
        }
        if userInputTextField.text != nil {
            userCorrectLetters = Array(repeating: "_", count: Int(userInputTextField.text!.count))
            guessLabel.text = "You have \(guessCount) guesses left"
            for letter in userInputTextField.text! {
                if storedUserInput.contains(String(letter)){
                    wordLabel.text = "\(letter, terminator: " ")"
                } else {
                    wordLabel.text = userCorrectLetters.joined(separator: " ")
                }
                userInputTextField.text = userInputTextField.text?.uppercased()
                return true
            }
            
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}




