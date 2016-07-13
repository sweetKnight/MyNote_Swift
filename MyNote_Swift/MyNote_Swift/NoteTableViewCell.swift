//
//  NoteTableViewCell.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

typealias deleteCellWithIndex = (index: NSIndexPath)->Void  //声明闭包

class NoteTableViewCell: SmartTableViewCell {
    var bgView:UIView!
    var headImageView: UIImageView!
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var timeLabel: UILabel!
    var deleteButton: UIButton!
    var offeseWitdh: CGFloat! = 35
    
    var index:NSIndexPath?
    var myDelete: deleteCellWithIndex? //定义闭包属性
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bgView = UIView()
        self.addSubview(bgView)
        
        headImageView = UIImageView(image: UIImage(named: "note_image_baseBg"))
        bgView.addSubview(headImageView)
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFontOfSize(15.0)
        titleLabel.textAlignment = NSTextAlignment.Left
        titleLabel.textColor = getColor("999999")
        bgView.addSubview(titleLabel)
        
        messageLabel = UILabel()
        messageLabel.font = UIFont.boldSystemFontOfSize(14.0)
        messageLabel.textAlignment = NSTextAlignment.Left
        messageLabel.textColor = getColor("999999")
        bgView.addSubview(messageLabel)
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.boldSystemFontOfSize(10.0)
        timeLabel.textAlignment = NSTextAlignment.Right
        timeLabel.textColor = getColor("999999")
        bgView.addSubview(timeLabel)
        
        deleteButton = UIButton()
        deleteButton.setBackgroundImage(UIImage(named: "cell_delete"), forState: UIControlState.Normal)
        deleteButton.addTarget(self, action: #selector(self.deleteCell), forControlEvents: UIControlEvents.TouchUpInside)
        bgView.addSubview(deleteButton)
        
        let leftSwipeGesture:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(self.leftSwipe))
        leftSwipeGesture.direction=UISwipeGestureRecognizerDirection.Left;
        
        let rightSwipeGesture:UISwipeGestureRecognizer! = UISwipeGestureRecognizer(target: self, action: #selector(self.rightSwipe))
        rightSwipeGesture.direction=UISwipeGestureRecognizerDirection.Right;
        bgView.gestureRecognizers = [leftSwipeGesture, rightSwipeGesture]
    }
    
    override func layoutSubviews() {
        bgView.frame = CGRectMake(0, 0, self.bounds.size.width + 35, self.bounds.size.height);
        headImageView.frame = CGRectMake(10, 10, self.bounds.size.height - 20, self.bounds.size.height - 20)
        headImageView.layer.cornerRadius = headImageView.bounds.size.height/4;
        headImageView.layer.masksToBounds = true
        messageLabel.frame = CGRectMake(headImageView.frame.maxX+10, headImageView.bounds.size.height/2+10, self.bounds.size.width - headImageView.frame.maxX-20, headImageView.bounds.size.height/2)
        let tempRect:CGRect = CGRectOffset(messageLabel.frame, 0, -messageLabel.bounds.size.height)
        titleLabel.frame = CGRectMake(tempRect.origin.x, tempRect.origin.y, tempRect.size.width/3*2, tempRect.size.height);
        timeLabel.frame = CGRectMake(titleLabel.frame.maxX, titleLabel.frame.minY, messageLabel.bounds.size.width - titleLabel.bounds.size.width, titleLabel.frame.size.height)
        
        deleteButton.frame = CGRectMake(self.bounds.size.width, 0, 35, self.bounds.size.height);
    }
    
    func deleteCell(){
        if (myDelete != nil) {
            myDelete!(index: index!)
        }
    }
    
     func leftSwipe(){
        if (bgView.frame.origin.x == 0) {
            UIView.animateWithDuration(0.25, animations: { 
                self.bgView.frame = CGRectOffset(self.bgView.frame, -self.offeseWitdh+2, 0)
            })
        }
    }
    
     func rightSwipe(){
        if (Int(bgView.frame.origin.x) == Int(-offeseWitdh+2)) {
            UIView.animateWithDuration(0.25, animations: {
                self.bgView.frame = CGRectOffset(self.bgView.frame, self.offeseWitdh-2, 0)
            })
        }
    }
    
    internal func initWithClosure(closure: deleteCellWithIndex?){
        myDelete = closure
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
