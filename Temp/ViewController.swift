//
//  ViewController.swift
//  Temp
//
//  Created by vincent on 2/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit
import CryptoSwift
import JWT
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, MyAlertMsg {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var userId: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "login-bg")
        let blurredImage = image!.imageByApplyingBlurWithRadius(6)
        self.view.layer.contents = blurredImage.CGImage
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: UIButton) {
        
        if username.text != "" && password.text != ""
        {
            //123456789001
            //123456
            let userNameText = username.text
            let passwordText = (password.text?.md5())!
            Alamofire.request(.POST, "http://192.168.137.1:80/login", parameters: ["username": userNameText!,"password":passwordText,"device":"APP"])
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        if let json = response.result.value {
                            let myJosn = JSON(json)
                            //                            print("\(myJosn.dictionary!["status"]!.stringValue)")
                            let code:Int = Int(myJosn["status"].stringValue)!
                            
                            if code == 400 {
                                self.alertMsg(myJosn.dictionary!["message"]!.stringValue,view: self, second: 2)
                            }
                            else{
                                let jwt = JWTTools()
                                NSLog(myJosn.dictionary!["message"]!.stringValue)
                                jwt.token = myJosn.dictionary!["message"]!.stringValue
                                
                                NSLog("\(jwt.getHeader(jwt.token, myDictionary: [:]))")
                                
                                self.view.makeToast("登陆成功", duration: 1, position: .Top)
                                
                                self.performSegueWithIdentifier("login", sender: self)
                            }
                            
                        }
                    case .Failure:
                        self.alertMsg("服务器错误",view: self, second: 2)
                    }
            }
            
        }
        else
        {
            self.alertMsg("帐号或密码为空",view: self, second: 2)
        }
        
        
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}





extension UIViewController {
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    //
    //
    //    override func viewDidLoad() {
    //        self.view.layer.contents = UIImage(named: "Backgroup.png")?.CGImage
    //        // Do any additional setup after loading the view.
    //    }
    
}


@IBDesignable class UIButtonTypeView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.backgroundColor = UIColor.clearColor()
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        self.layer.cornerRadius = cornerRadius
        
    }
}