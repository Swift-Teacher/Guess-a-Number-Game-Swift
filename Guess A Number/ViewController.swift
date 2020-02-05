//
//  ViewController.swift
//  Guess A Number
//
//  Created by Mark Dalton on 02/03/20.
//  Copyright © 2020 Dalton Technologies, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// Submit button the user presses after entering a number
    @IBOutlet private var submitButton: UIButton!
    
    /// Text input for the user to enter a guessed number
    @IBOutlet private var guessTextField: UITextField!
    
    /// Text to display number of tries the user guesses a number
    @IBOutlet private var numOfTriesLabel: UILabel!
    
    /// Text to display the result message of a guessed number
    @IBOutlet private var infoLabel: UILabel!
    
    /// Random number guessed in game
    private var randomNumber = 0
    
    /// Number of tries the user guesses a number
    private var numOfTries = 0
    
    /// Message displayed when the user guesses the correct random number
    private let CORRECT = "Congrats! You guessed the right number!"
    
    /// Message displayed when the user guesses a number below the random number
    private let TOO_LOW = "Try again. Guess a number higher than "
    
    /// Message displayed when the user guesses a number above the random number
    private let TOO_HIGH = "Try again. Guess a number lower than "
    
    /// Prefix for message displaying the number of tries the user guesses a number
    private let NUM_OF_TRIES_PREFIX = "# of Tries: "
    
    /// Button title to replace submit button title when the game has ended
    private let PLAY_AGAIN_TITLE = "PLAY AGAIN"
    
    /// Button title to replace submit button title when the game has ended
    private let SUBMIT_TITLE = "SUBMIT"
    
    /// Maximum limit for the random number
    private let MAX_NUM = 100
    
    /// Minimum limit for the random number
    private let MIN_NUM = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //generate random number used for first round of game
        generateRandomNumber()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //open the keyboard on the guess text field when the app opens
        guessTextField.becomeFirstResponder()
    }
    
    /// submit action when user taps on the submit button
    /// - Parameter sender: button sender that is tapped
    @IBAction func submitAction(_ sender: Any) {
        
        //check if the submit button title is indicating to play again
        if(submitButton.titleLabel?.text == PLAY_AGAIN_TITLE){
            
            //play another round of the game
            playAgain()
        }
        
        //else the submit button title is indicating to submit a guess
        else{
            
            //submit a guessed number
            submit()
        }
        
    }
    
    /// Submit a guessed number to see the result
    func submit(){
     
        //get the guessed number string from the text input
        let guessString = guessTextField.text!
        
        //check to skip guess attempt when this string is empty
        if(guessString.isEmpty){
            return
        }
        
        //convert string into an integer
        let currentNum = Int(guessString)!
        
        //message to display result of the guess
        var message = String(describing: currentNum) + "!"
        
        //check if the guessed number is the random number
        if(currentNum == randomNumber){
            
            //set correct result message
            message = CORRECT
            
            //change the submit button accordingly to allow playing again
            submitButton.setTitle("PLAY AGAIN", for: .normal)
        }
        
        //else the guessed number is not correct
        else{
            
            //increment the number of tries by 1
            setNumOfTries(number: numOfTries + 1)
            
            //check if guessed number is less than random number
            //and set result message as too low or high accordingly
            message = currentNum < randomNumber ? TOO_LOW : TOO_HIGH
            
            //clear out the text input for another guess
            guessTextField.text = ""
        }
        
        //display the result of the guess on the info label
        infoLabel.text = message
        
    }
    
    /// Set the number of tries on
    /// - Parameter number: the new number of tries attempted
    func setNumOfTries(number: Int){
        
        //set number of tries to new value
        numOfTries = number
        
        //convert the integer parameter to a string
        let numberString = String(describing: number)
        
        //set the number of tries label to display the new number of tries
        numOfTriesLabel.text = NUM_OF_TRIES_PREFIX + numberString
    }
    
    /// Procedure for resetting the game to play again
    func playAgain(){
        
        //generate a new random number
        generateRandomNumber()
        
        //change the submit button accordingly to allow submitting guesses again
        submitButton.setTitle(SUBMIT_TITLE, for: .normal)
        
        //reset the number of tries
        setNumOfTries(number: 0)
        
        //clear out the input text
        guessTextField.text = ""
        
        //clear out the info label
        infoLabel.text = ""
        
    }
    
    /// Generate a random number
    func generateRandomNumber(){
        
        //the random number set is between and including the min and max limits
        randomNumber = Int.random(in: MIN_NUM ... MAX_NUM)
    }

}

