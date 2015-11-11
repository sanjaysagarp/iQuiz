//
//  ViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/2/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
    var quiz: [Question] = [Question(question: "", answers: [], correctAnswer: "")]
    
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
            if button.currentTitle == quiz[questionIndex].correctAnswer { //answer check
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
        if numberSubmissions < quiz.count {
            nextButton.enabled = true
        }
        if numberSubmissions >= quiz.count {
            doneButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        submit.enabled = false
        nextButton.enabled = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        if self.questionIndex < quiz.count {
            questionText.text! = quiz[questionIndex].question
            answer1.setTitle(quiz[questionIndex].answers[0], forState: .Normal)
            answer2.setTitle(quiz[questionIndex].answers[1], forState: .Normal)
            answer3.setTitle(quiz[questionIndex].answers[2], forState: .Normal)
            answer4.setTitle(quiz[questionIndex].answers[3], forState: .Normal)
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
            destinationVC.title = "\(destinationVC.questionIndex + 1) of \(quiz.count)"
            destinationVC.numberSubmissions = self.numberSubmissions
            destinationVC.correct = self.correct
            destinationVC.quiz = self.quiz
        } else if segue.identifier == "FinishedSegue" {
            let destinationVC = segue.destinationViewController as! FinishedViewController
            destinationVC.title = "YOU DID IT!"
            destinationVC.correct = self.correct
            destinationVC.numberOfQuestions = self.quiz.count
        }
        
        
    }
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                self.performSegueWithIdentifier("unwindToMainMenu", sender: self)
            case UISwipeGestureRecognizerDirection.Left:
                if numberSubmissions == quiz.count {
                    self.performSegueWithIdentifier("FinishedSegue", sender: self)
                } else if numberSubmissions == questionIndex + 1 {
                    self.performSegueWithIdentifier("questionSegue", sender: self)
                }
            default:
                break
            }
        }
    }
}

