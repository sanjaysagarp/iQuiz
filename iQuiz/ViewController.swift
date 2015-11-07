//
//  ViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/2/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit

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
    
    @IBAction func answerButton(sender: UIButton) {
        submit.alpha = 1;
        sender.layer.borderWidth = 4
        sender.layer.borderColor = UIColor.blackColor().CGColor
        sender.selected = true
    }
    @IBAction func submitButton(sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

