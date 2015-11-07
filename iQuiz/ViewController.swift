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
    var mathQuestions: [String:[String]] = [
        "4 + 7 = " : ["2","3","11","9"]
    ]
    
    var question: String = ""
    var questionIndex: Int = 0;
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var submit: UIButton!
    
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
        
        for button in self.buttons {
            if button.currentTitle == "11" { //answer check
                if button.selected {
                    button.layer.backgroundColor = UIColor.greenColor().CGColor
                } else {
                    button.layer.borderWidth = 4
                    button.layer.borderColor = UIColor.redColor().CGColor
                }
            }
            button.enabled = false
        }
        sender.enabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        submit.enabled = false
        questionText.text! = "4 + 7 = "
        answer1.setTitle("2", forState: .Normal)
        answer2.setTitle("3", forState: .Normal)
        answer3.setTitle("11", forState: .Normal)
        answer4.setTitle("9", forState: .Normal)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

