//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/17/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    

    @IBOutlet weak var textInput: UITextField!
    @IBAction func UpdateQuiz(sender: AnyObject) {
        newURL = textInput.text!
    }
    var newURL: String = "http://tednewardsandbox.site44.com/questions.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! TableViewController
        destinationVC.URL = newURL
        destinationVC.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
