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
    var mathQuestions: [String] = ["4 + 7 = ","3 * 3 = ", "3 * 4 = ", "3 * 5 = ", "3 * 6 = "]
    var mathPossible: [Int:[String]] = [
        0 : ["2","3","11","9"],
        1 : ["9","0","5","2"],
        2 : ["12","0","5","2"],
        3 : ["2","5","12","15"],
        4 : ["9","18","5","15"]
    ]
    var mathAnswers: [String] = ["11","9","12","15","18"]
    //var question: String = ""
    var questionRowIndex: Int = 0 //From categories 0 = Math,  1 = Marvel, 2 = Science
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
            if button.currentTitle == mathAnswers[questionIndex] { //answer check
                if button.selected {
                    button.layer.backgroundColor = UIColor.greenColor().CGColor
                    self.correct = self.correct + 1
                    print(correct)
                } else {
                    button.layer.borderWidth = 4
                    button.layer.borderColor = UIColor.redColor().CGColor
                }
            }
            button.enabled = false
        }
        sender.enabled = false
        if numberSubmissions >= 5 && nextButton.title == "Done" {
            nextButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        submit.enabled = false
        
        //print (self.questionIndex)
        if self.questionIndex < 5 {
            var answerTexts = mathPossible[questionIndex]
            questionText.text! = mathQuestions[questionIndex]
            answer1.setTitle(answerTexts![0], forState: .Normal)
            answer2.setTitle(answerTexts![1], forState: .Normal)
            answer3.setTitle(answerTexts![2], forState: .Normal)
            answer4.setTitle(answerTexts![3], forState: .Normal)
        } else { // says congrats
            
            for button in buttons {
                button.hidden = true
            }
            submit.hidden = true
            self.title = ""
            print(correct)
            self.questionText.text! = "You got \(self.correct) out of 5"
        }
        
        // Will probably use this to fix bug of returning to refreshed question
        /*if numberSubmissions >= 5 && nextButton.title == "Done" {
            nextButton.enabled = true
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let destinationVC = segue.destinationViewController as! ViewController
        destinationVC.questionIndex = self.questionIndex + 1
        if destinationVC.questionIndex < 5 {//Limits number of questions to 5
            destinationVC.title = "\(destinationVC.questionIndex + 1) of 5"
            //destinationVC.question = mathQuestions[destinationVC.questionRowIndex + 1]
            //print (destinationVC.questionIndex)
        }
        
        if questionIndex >= 3 {
            destinationVC.nextButton.title = "Menu"
            destinationVC.nextButton.enabled = false;
        }
        destinationVC.numberSubmissions = self.numberSubmissions
        destinationVC.correct = self.correct
        
    }

}

