//
//  register.swift
//  Temp
//
//  Created by vincent on 2/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import UIKit
import Eureka
import Foundation
import CoreLocation
import IBAnimatable

import CryptoSwift
import JWT
import Alamofire
import SwiftyJSON

class RegisterViewController: UIViewController, MyAlertMsg {
    
    @IBOutlet var mobilePhone: AnimatableTextField!
    @IBOutlet var codes: AnimatableTextField!
    @IBOutlet var password: AnimatableTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getCodes(sender: UIButton) {
        SMSSDK.getVerificationCodeByMethod(SMSGetCodeMethodSMS, phoneNumber: mobilePhone.text, zone: "86", customIdentifier: nil) { (error : NSError!) -> Void in
            
            if (error == nil)
            {
                self.alertMsg("请求成功,请等待短信～",view: self, second: 2)
            }
            else
            {
                // 错误码可以参考‘SMS_SDK.framework / SMSSDKResultHanderDef.h’
                self.alertMsg("请求失败",view: self, second: 2)
            }
        }
    }
    
    
    @IBAction func verifyCodes(sender: UIButton) {
        SMSSDK.commitVerificationCode(codes.text, phoneNumber: mobilePhone.text, zone: "86") { (error : NSError!) -> Void in
            if(error == nil){
                self.alertMsg("验证成功",view: self, second: 2)
            }else{
                self.alertMsg("验证失败",view: self, second: 2)
            }
        }
    }
    
    @IBAction func register(sender: AnyObject) {
//        
//        let userNameText = mobilePhone.text
//        let passwordText = (password.text?.md5())!
//        Alamofire.request(.POST, "http://192.168.137.1/user/register", parameters: ["username": userNameText!,"password":passwordText,"device":"APP"])
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .Success:
//                    if let json = response.result.value {
//                        let myJosn = JSON(json)
//                        print("\(myJosn.dictionary!["status"]!.stringValue)")
//                        let code:Int = Int(myJosn["status"].stringValue)!
//                        
//                        if code == 400 {
//                            self.alertMsg(myJosn.dictionary!["detail"]!.stringValue,view: self, second: 2)
//                        }
//                        else{
//                            let jwt = JWTTools()
//                            jwt.token = myJosn.dictionary!["token"]!.stringValue
//                            
//                            self.view.makeToast("注册成功", duration: 1, position: .Top)
//                            
//                            self.dismissViewControllerAnimated(true, completion: nil)
//                            
//                            self.performSegueWithIdentifier("login", sender: self)
//                        }
//                        
//                    }
//                case .Failure:
//                    self.alertMsg("服务器错误",view: self, second: 2)
//                }
//        }

    }
}

//private var mButtonObj: ButtonCreation?
//
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    mButtonObj = ButtonCreation()
//    mButtonObj?.createButton(self.view)
//    
//}

//class ButtonCreation: NSObject {
//
//    func createButton(baseView: UIView) {
//        let button = UIButton(frame:CGRectMake(10, 150, 100, 30))
//        button.setTitle("Tap Me", forState: UIControlState.Normal)
//        button.addTarget(self, action: Selector("buttonTouched:"), forControlEvents: UIControlEvents.TouchUpInside)
//        baseView.addSubview(button)
//    }
//    
//    func buttonTouched(sender: AnyObject) {
//        print("Button touched!")
//    }
//}


