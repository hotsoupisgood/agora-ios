//
//  questionTableViewController.swift
//  agora-ios
//
//  Created by Mac on 12/21/16.
//  Copyright © 2016 This Agora. All rights reserved.
//

import UIKit
import Alamofire

class QuestionTableViewController: UITableViewController {
    //MARK: Properties
    var stream = NSArray()
    var currentFocused = NSInteger()
    var page = NSInteger()
    let offset = 28
    var isLoading = false
    let order = "date"
    var limit = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestions()
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stream.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "QuestionTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QuestionTableViewCell  else {
            fatalError("The dequeued cell is not an instance of QuestionTableViewCell.")
        }
        // Fetches the appropriate question for the data source layoNSDictionaryut.
        let question = stream[indexPath.row] as! NSDictionary
        cell.tagArray = question["tags"] as! NSArray
        cell.questionTextView.text = question["text"] as! String

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Private Methods
    private func loadQuestions() {
        isLoading = true
        let parameters: Parameters = [
            "limit": limit,
            "offset": offset,
            "order_by": order
        ]
        Alamofire.request("http://api.iex.ist/full/question/", parameters: parameters).responseJSON { response in
            print("Success: \(response.result.isSuccess)")
//            print("Response String: \(response.result.value)")
            
            if let result = response.result.value {
                var whole: NSDictionary = result as! NSDictionary
                self.stream = whole["objects"] as! NSArray
                self.isLoading = false
                //swift 3
//                DispatchQueue.main.async{
//                    self.tableView.reloadData()
//                }
                self.tableView.reloadData()
            }
        }
    }
    //MARK: Extensions
    
    
}
