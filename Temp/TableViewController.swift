//
//  TableViewController.swift
//  Temp
//
//  Created by vincent on 4/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit
import CryptoSwift
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper


class TableViewController: UITableViewController {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var books = [Book]()
    


    override func viewDidLoad() {
        
        books.removeAll()
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        sleep(1)//吐司延时
        //refreshData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        books.removeAll()
        super.viewWillAppear(true)
        self.refreshData()
    }
    
    
    func insertNewObject(sender: AnyObject) {
        getBook()
    }
    
    func refreshData()
    {
        if refreshControl != nil {
            refreshControl!.beginRefreshing()
        }
        refresh(refreshControl!)
    }
    
    
    func getBook()
    {
        
        
//        let random = arc4random_uniform(100)
//        let stateMe = random > 50 ? "123123" : "2222222"
//        let book = Book(inId: "\(random)", inContent: stateMe, inTitle: "\(random)"+"123", inDate: NSDate() )
//        books.append(book)
//
        
        let jwt = JWTTools()
        let newDict = Dictionary<String,String>()
        let headers = jwt.getHeader(jwt.token, myDictionary: newDict)
        
        Alamofire.request(.GET, "http://192.168.137.1:80/book/all", headers: headers)
            .responseArray { (response: Response<[Book], NSError>) in
                let bookList = response.result.value
                if let list = bookList {
                    for book in list {
                        self.books.append(book)
                    }
                    
                    self.tableView.reloadData()
                }
        }

    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        books.removeAll()
        getBook()
        
        refreshControl!.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookInfo", forIndexPath: indexPath) as! BookTableViewCell

        // Configure the cell...
        let bookCell = books[indexPath.row] as Book
        cell.title.text = bookCell.title
        cell.id.text = bookCell.id
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.FullStyle
        cell.content.text = dateFormatter.stringFromDate(bookCell.publicDate)
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let bookCell = books[indexPath.row] as Book
            books.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            let jwt = JWTTools()
            let newDict: [String: String] = [:]//["id": bookCell.id]
            let headers = jwt.getHeader(jwt.token, myDictionary: newDict)
            Alamofire.request(.DELETE, "http://192.168.137.1:80/book/pathDelete/\(bookCell.id)",headers:headers)
                .responseJSON { response in
                    
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showBook" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = books[indexPath.row] as Book
                (segue.destinationViewController as! BookViewController).detailItem = object
            }
        }
    }


}
