//
//  PublicFunctionWithSweet.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

let DEF_SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let DEF_SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height
let MyNotesListArray = "MyNotesListArray"

enum MyError: ErrorType {
    case NoCopy
    case Error1
}

public func getColor(colorCode: String, alpha: Float = 1.0) -> UIColor {
    let scanner = NSScanner(string:colorCode)
    var color:UInt32 = 0;
    scanner.scanHexInt(&color)
    
    let mask = 0x000000FF
    let r = CGFloat(Float(Int(color >> 16) & mask)/255.0)
    let g = CGFloat(Float(Int(color >> 8) & mask)/255.0)
    let b = CGFloat(Float(Int(color) & mask)/255.0)
    
    return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
}

public func showMessage(message:NSString){
    let alertView:UIAlertView! = UIAlertView()
    alertView.message = message as String
    alertView.show()
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64((3 * NSEC_PER_SEC))), dispatch_get_main_queue()) {
        alertView.dismissWithClickedButtonIndex(alertView.cancelButtonIndex, animated: true)
    }
}