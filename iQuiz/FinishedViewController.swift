//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/7/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var correct: Int = 0
    @IBOutlet weak var winningText: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBAction func backToMenu(sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 7], animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if correct <= 2 {
            winningText.text = "NOOO.\nBelieve in yourself!"
        } else if correct == 3 {
            winningText.text = "It's okay, \nyou can do better \nnext time"
        } else if correct == 4 {
            winningText.text = "So close!"
        } else {
            winningText.text = "My bad, \nwe have a hot shot \nover here"
        }
        score.text = "\(correct) out of 5"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
