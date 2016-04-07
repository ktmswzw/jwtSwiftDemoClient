//
//  Book.swift
//  Temp
//
//  Created by vincent on 4/2/16.
//  Copyright © 2016 xecoder. All rights reserved.
//

import Foundation

import SAWaveToast
import ObjectMapper
import AlamofireObjectMapper




public class Book: Mappable
{
    
    var id: String = "";
    var content: String = "";
    var title: String = "";
    var publicDate: NSDate = NSDate();
    
    init(inId:String, inContent:String, inTitle:String, inDate:NSDate)
    {
        id = inId
        content = inContent
        title = inTitle
        publicDate = inDate
    }
    
    
    public required init?(_ map: Map){
        
    }
    
//    
    public func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        title <- map["title"]
        publicDate <- map["publicDate"]
    }
    
    
    
}
protocol MyAlertMsg{
    func alertMsg(str: String ,view: UIViewController, second: NSTimeInterval)
}

extension MyAlertMsg{
    func alertMsg(str: String, view: UIViewController, second: NSTimeInterval) {
        let waveToast = SAWaveToast(text: str, font: .systemFontOfSize(16), fontColor: .darkGrayColor(), waveColor: .cyanColor(), duration: second)
        view.presentViewController(waveToast, animated: false, completion: nil)
    }
}
