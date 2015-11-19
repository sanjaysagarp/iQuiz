//
//  TableViewController.swift
//  iQuiz
//
//  Created by Sanjay Sagar on 11/2/15.
//  Copyright © 2015 Sanjay Sagar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct Question {
    var question : String
    var answers : [String]
    var correctAnswer : String
}

class TableViewController: UITableViewController {
    
    var subjects = ["Science", "Marvel Super Heroes", "Mathematics"]
    var descriptions = ["Science is best bro","HULK SMASH","x + y = z"]
    var URL = "http://tednewardsandbox.site44.com/questions.json"
    var questions = [Question]()
    var Quizes = [[Question]]()
    
    @IBAction func unwindToMainMenu(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, self.URL).validate().responseJSON { response in
            if let value = response.result.value {
                let json = JSON(value)
                self.setQuizQuestions(json)
                
            } else {
                print("Cannot fetch data, using local")
                self.getQuizzesFromFileWithSuccess { (data) -> Void in
                    let json = JSON(data: data)
                    self.setQuizQuestions(json)
                }
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })

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
        cell.detailTextLabel!.text = descriptions[indexPath.row] // description goes here
        
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
  

            destinationVC.quiz = Quizes[index.row]
            destinationVC.title = "1 of \(destinationVC.quiz.count)"
            
        }
    }
    
    func getQuizzesFromFileWithSuccess(success: ((data: NSData) -> Void)) {

        let filePath = NSBundle.mainBundle().pathForResource("Quizzes",ofType:"json")

        do {
            let data = try NSData(contentsOfFile:filePath!, options: NSDataReadingOptions.DataReadingUncached)
            success(data: data)
        } catch {
            print("Could not fetch from local")
        }
    }
    
    func setQuizQuestions(json: JSON) {
        subjects = [String]()
        descriptions = [String]()
        let subjectArray = json.array
        
        for index in 0...(subjectArray!.count - 1) {
            //parses through the 3 'bulks'
            questions = [Question]()
            subjects += [json[index]["title"].stringValue]
            descriptions += [json[index]["desc"].stringValue]
            let questionsJSON = json[index]["questions"].array
            for q in questionsJSON! {
                questions += [Question(question: q["text"].stringValue, answers: [q["answers"][0].stringValue, q["answers"][1].stringValue, q["answers"][2].stringValue, q["answers"][3].stringValue, ], correctAnswer: q["answers"][q["answer"].intValue - 1].stringValue)]
            }
            Quizes += [questions]
        }
    }

}
