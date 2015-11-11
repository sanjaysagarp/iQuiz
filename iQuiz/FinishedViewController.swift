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
    var numberOfQuestions: Int = 0
    @IBOutlet weak var winningText: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBAction func backToMenu(sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - (numberOfQuestions + 2)], animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if correct == numberOfQuestions {
            winningText.text = "Superb!"
        } else if correct <= numberOfQuestions / 4 {
            winningText.text = "NOT GOOD ENOUGH!"
        } else if correct <= (3 * numberOfQuestions) / 4 {
            winningText.text = "It's okay, you can do better next time"
        } else {
            winningText.text = "So close!"
        }
        score.text = "\(correct) out of \(numberOfQuestions)"
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
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
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - (numberOfQuestions + 2)], animated: true)
            default:
                break
            }
        }
    }
}
