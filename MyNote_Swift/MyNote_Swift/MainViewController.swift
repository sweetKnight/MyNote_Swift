//
//  MainViewController.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/26.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: init
    var dataArray:NSMutableArray!
    var tableView:UITableView!
    let cellIndentifier = "cellIndebtifier"
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Notes"
        tableView = UITableView(frame: CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //接口
        dataArray = NoteBl.findAll()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: EVENT UITableViewDataSource
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1;
    }
    
    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return dataArray.count;
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell: NoteTableViewCell = NoteTableViewCell.cellForTableView(tableView) as! NoteTableViewCell
        cell.index = indexPath
        cell.initWithClosure(delteThisNote)
        
        let note:Note! = dataArray.objectAtIndex(indexPath.section) as! Note
        
        let data:NSData! = (note! as Note).image!
        let dateNoImage = "noImage".dataUsingEncoding(NSUTF8StringEncoding)
        
        if !(data.isEqualToData(dateNoImage!)) {
            let image:UIImage = UIImage(data: (note! as Note).image!)!
            cell.headImageView.image = image
        }
        cell.titleLabel.text = note.title as String!
        let string = NSString.localizedStringWithFormat("%@", note.date!) as String
        let range:NSRange = NSMakeRange(0,10)
        cell.timeLabel.text = (string as NSString).substringWithRange(range)
        cell.messageLabel.text = note.content as String!
        
        return cell
    }
    
    //MARK: EVENT UITableViewDelegate
    internal func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 75;
    }
    
    internal func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }
    
    internal func headerViewForSection(section: Int) -> UITableViewHeaderFooterView?{
        let headView:UITableViewHeaderFooterView = UITableViewHeaderFooterView()
        headView.backgroundColor = UIColor.clearColor()
        headView.frame = CGRectMake(0, 0, DEF_SCREEN_WIDTH, 10)
        return headView
    }
    
    internal func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let note:Note! = dataArray.objectAtIndex(indexPath.section) as! Note
        self.pushNoteDetailViewControllerWithNoteString(note)
    }
    
    @IBAction func addNewNoteEvent(sender: AnyObject) {
        self.pushNoteDetailViewControllerWithNoteString(nil)
    }

    //MARK: CUSTEM METHODS
    private func pushNoteDetailViewControllerWithNoteString(note:Note?){
        let noteVc: NoteDetailViewController = self.storyboard!.instantiateViewControllerWithIdentifier("NoteDetailViewController") as! NoteDetailViewController
        noteVc.baseNote = note
        if note == nil {
            noteVc.isCreate = true
        }else{
            noteVc.isCreate = false
        }
        self.navigationController?.pushViewController(noteVc, animated: true)
    }
    
    func delteThisNote(index: NSIndexPath) -> Void {
        let item = dataArray.objectAtIndex(index.section)
        let note:Note = item as! Note
        dataArray = NoteBl.remove(note)
        tableView.deleteSections(NSIndexSet(index: index.section), withRowAnimation: UITableViewRowAnimation.None)
        tableView.reloadData()
    }
}
