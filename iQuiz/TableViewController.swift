//
//  TableViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/2/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit

struct Question {
    var question : String
    var answers : [String]
    var correctAnswer : String
}

class TableViewController: UITableViewController {
    
    let subjects = ["Mathematics", "Marvel Super Heroes", "Science"]
    
    let MathQuiz = [Question(question: "4 + 7 =", answers: ["1","2","11","8"], correctAnswer: "11"), Question(question: "1 + 2 =", answers: ["1","2","3","4"], correctAnswer: "3"), Question(question: "2 - 1", answers: ["1","2","3","4"], correctAnswer: "1"), Question(question: "1 * 2", answers: ["1","2","3","4"], correctAnswer: "2")]
    
    let DefaultQuiz = [Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"), Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"), Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"), Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"), Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"), Question(question: "Insert Question Here", answers: ["Answer1","Answer2","Answer3","Answer4"], correctAnswer: "Answer1"),]
    
    @IBAction func displaySettings(sender: AnyObject) {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Settings go here!", message: nil, preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }*/

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }
    
    /*
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }*/
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubjectCell", forIndexPath: indexPath)
        let image : UIImage = UIImage(named: "Question_Flat.png")!
        cell.imageView!.image = image // need image for each quiz
        cell.textLabel?.text = subjects[indexPath.row]
        cell.detailTextLabel!.text = "A sentence goes here" // description goes here
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    /*
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowQuestionSegue"
        {
            let destinationVC = segue.destinationViewController as! ViewController
            let index = tableView.indexPathForSelectedRow!
            
            if index.row == 0 { // math
                destinationVC.quiz = self.MathQuiz
                
            } else if index.row == 1 { // Marvel Super Heroes
                destinationVC.quiz = self.DefaultQuiz
           
            } else if index.row == 2 { // Science
                destinationVC.quiz = self.DefaultQuiz
            }
            destinationVC.title = "1 of \(destinationVC.quiz.count)"
            
        }
    }

}
