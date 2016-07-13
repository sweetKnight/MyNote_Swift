//
//  SmartTableViewCell.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class SmartTableViewCell: UITableViewCell {

    class func cellIdentifier()->NSString{
        return NSStringFromClass(SmartTableViewCell)
    }
    
    class func cellForTableView(tableView:UITableView?)->AnyObject{
        let cellID:NSString! = self.cellIdentifier()
        var cell: UITableViewCell! = tableView?.dequeueReusableCellWithIdentifier(cellID as String)
        if cell == nil {
            cell = super.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellID as String)
        }
//        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
