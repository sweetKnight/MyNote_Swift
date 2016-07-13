//
//  Note.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/27.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class Note{
    
    var content : NSString?
    var title : NSString?
    var date : NSDate?
    var image : NSData?
    
     func initWithDic(dic: NSDictionary) -> Void {
        title = dic.objectForKey("noteTitle") as? NSString
        content = dic.objectForKey("noteContent") as? NSString
        date = dic.objectForKey("noteData") as? NSDate
        image = dic.objectForKey("noteImage") as? NSData
    }
    
    func chageToDictionary() -> NSDictionary {
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic.setObject(title!, forKey: "noteTitle")
        dic.setObject(content!, forKey: "noteContent")
        dic.setObject(date!, forKey: "noteData")
        dic.setObject(image!, forKey: "noteImage")
        let dict :NSDictionary = NSDictionary.init(dictionary: dic)
        return dict
    }
}
