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
    var userCorrectLetters = Array(repeating: "_", count: activeWord.count)
    var placeHolder = String()
    var storedUserInput = [String]()
   
    
    @IBOutlet weak var cohortInputTextField: UITextField!
     @IBOutlet weak var userInputTextField: UITextField!

    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var hangManImage: UIImageView!
    
//    var placeHolder = String(repeating: "_", count: userInputTextField.count)
    override func viewDidLoad() {
    super.viewDidLoad()
    userInputTextField.delegate = self
    cohortInputTextField.delegate = self
    
    // Do any additional setup after loading the view, typically from a nib.
  }
}

extension ViewController: UITextFieldDelegate {
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        while guessCount > 0 {
            guessLabel.text = "You have 6 guesses left"
            for letter in userInputTextField.text ?? ""{
                if userInputTextField.contains(String(letter) as! UIFocusEnvironment){
                    wordLabel.text = "\(letter, terminator: " ")"
                } else {
                    wordLabel.text = "\("_", terminator: " ")"
                }
            }
            if let cohortInputTextField.text ?? "" {
                print(" You played the letter \(cohortInputTextField.text ?? "")")
                
                guard alphabet.contains(cohortInputTextField.text ?? "")  else {
                    guessLabel.text = "That's not a valid letter! Please choose a letter."
                    continue
                }
                
                guard !storedUserInput.contains(cohortInputTextField.text ?? "") else {
                    guessLabel.text = "Uh oh. Looks like you used this letter already. Try again!"
                    continue
                }
                storedUserInput.append(cohortInputTextField.text ?? "")
                
                if userInputTextField.contains(cohortInputTextField?.text as! UIFocusEnvironment ){
                    for (index, char) in userInputTextField.enumerated() {
                        if String(char) == cohortInputTextField.text ?? "" {
                            userCorrectLetters[index] = cohortInputTextField.text ?? ""
                        }
                    }
                    
                    guessLabel.text = "Correct Choice, you still have \(guessCount) chances left!"
                } else {
                    guessCount -= 1
                    guessLabel.text = "Incorrect selection! You have \(guessCount) chances left!"
                }
            } else {
                guessLabel.text = "That's not a valid Alphabet Character"
            }
        if userInputTextField.text == cohortInputTextField.text {
            print("It's a match")
        }
        
        return true
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        return true
    }
    }

}

