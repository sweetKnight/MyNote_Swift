//
//  BaseViewController.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: init
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = getColor("F7F7F7")
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = false
        
        let botton:UIBarButtonItem! = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = botton
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.boldSystemFontOfSize(25.0), NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK: EVENT
    
    //MARK: CUSTEM METHODS
    
}
