//
//  ViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/2/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit
struct question {
    //Each question has a questionText, possibleAnswers, answer
}
class ViewController: UIViewController {
    var questions: [String] = []
    var possibleAnswers: [Int:[String]] = [0:[]]
    var answers: [String] = []
    
    //var questionRowIndex: Int = 0 //From categories 0 = Math,  1 = Marvel, 2 = Science
    var questionIndex: Int = 0
    var correct: Int = 0
    var numberSubmissions: Int = 0
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    lazy var buttons: [UIButton] = [self.answer1, self.answer2, self.answer3, self.answer4]
    var userAnswer = ""
    
    @IBAction func answerButton(sender: UIButton) {
            for button in self.buttons {
                button.selected = false
                button.layer.borderWidth = 0
            }
            submit.alpha = 1;
            submit.enabled = true
            sender.layer.borderWidth = 4
            sender.layer.borderColor = UIColor.blackColor().CGColor
            sender.selected = true
            userAnswer = sender.currentTitle!
    }
    @IBAction func submitButton(sender: UIButton) {
        numberSubmissions++
        for button in self.buttons {
            if button.currentTitle == answers[questionIndex] { //answer check
                if button.selected {
                    button.layer.backgroundColor = UIColor.greenColor().CGColor
                    self.correct = self.correct + 1
                } else {
                    button.layer.borderWidth = 4
                    button.layer.borderColor = UIColor.redColor().CGColor
                }
            }
            button.enabled = false
        }
        sender.enabled = false
        if numberSubmissions < 5 {
            nextButton.enabled = true
        }
        if numberSubmissions >= 5 {
            doneButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        submit.enabled = false
        nextButton.enabled = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        if self.questionIndex < 5 {
            var answerTexts = possibleAnswers[questionIndex]
            questionText.text! = questions[questionIndex]
            answer1.setTitle(answerTexts![0], forState: .Normal)
            answer2.setTitle(answerTexts![1], forState: .Normal)
            answer3.setTitle(answerTexts![2], forState: .Normal)
            answer4.setTitle(answerTexts![3], forState: .Normal)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "questionSegue" {
            let destinationVC = segue.destinationViewController as! ViewController
            destinationVC.questionIndex = self.questionIndex + 1
            if destinationVC.questionIndex < 5 {//Limits number of questions to 5
                destinationVC.title = "\(destinationVC.questionIndex + 1) of 5"

            }
            
            if questionIndex >= 3 {
                destinationVC.nextButton.enabled = false;
            }
            destinationVC.numberSubmissions = self.numberSubmissions
            destinationVC.correct = self.correct
            destinationVC.possibleAnswers = self.possibleAnswers
            destinationVC.answers = self.answers
            destinationVC.questions = self.questions
        } else if segue.identifier == "FinishedSegue" {
            let destinationVC = segue.destinationViewController as! FinishedViewController
            destinationVC.title = "YOU DID IT!"
            destinationVC.correct = self.correct
            destinationVC.numberOfQuestions = self.questions.capacity
        }
        
        
    }

}

