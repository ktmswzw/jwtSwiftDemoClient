//
//  BookViewController.swift
//  Temp
//
//  Created by vincent on 4/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit
import Eureka
import JWT
import Alamofire
import SwiftyJSON

class BookViewController: FormViewController {
    
    var detailItem: Book?
    
    func initializeForm()
    {
        //        form = Section(header: "Settings", footer: "These settings change how the navigation accessory view behaves")
        //
        //
        //            +++ Section()
        
        //        form +++
        //            
        //            Section()
        //            
        //            <<< TextRow() {
        
        form
            = TextRow() {
                $0.title = "ID"
                $0.value = self.detailItem?.id
            }
            
            <<< TextRow() {
                $0.title = "Title"
                $0.value = self.detailItem?.title
            }
            
            
            +++ Section()
            
            <<< DateInlineRow() {
                $0.title = "Public Date"
                $0.value = self.detailItem?.publicDate
        }
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeForm()
        
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = "cancelTapped:"
        
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "deleteRow:")
        self.navigationItem.rightBarButtonItem = addButton
        
        // Do any additional setup after loading the view.
    }
    
    //    
    func deleteRow(sender: AnyObject) {
        deleteBook((self.detailItem?.id)!)
    }
    
    func deleteBook(id: String) {
        let jwt = JWTTools()
        let newDict: [String: String] = ["id": id]
        let headers = jwt.getHeader(jwt.token, myDictionary: newDict)
        Alamofire.request(.DELETE, "http://192.168.137.1:80/book/jwtDelete",headers:headers)
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let json = response.result.value {
                        let myJosn = JSON(json)
                        NSLog("\(myJosn)")
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                case .Failure:
                    NSLog("error ")
                }
        }
        
        
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
