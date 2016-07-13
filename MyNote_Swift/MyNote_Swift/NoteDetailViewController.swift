//
//  NoteDetailViewController.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/27.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class NoteDetailViewController: BaseViewController, UITextViewDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, UINavigationControllerDelegate {

    //MARK: init
    var baseNote:Note?
    var isCreate:Bool?
    
    let headButton:UIButton! = UIButton()
    let noteMessageTextView:UITextView! = UITextView()
    let textViewLabel:UILabel! = UILabel()
    let tiltelTextView:UITextField! = UITextField()
    var _image:UIImage!
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Note Message"
        
        let bgView:UIView! = UIView()
        bgView.frame = CGRectMake(0, 10, DEF_SCREEN_WIDTH, 45)
        self.view.addSubview(bgView)
        
        headButton.frame = CGRectMake(10, 10, 45, 45)
        headButton.layer.cornerRadius = headButton.bounds.size.height/4;
        headButton.layer.masksToBounds = true;
        headButton.setBackgroundImage(UIImage(named: "add_headImage"), forState: UIControlState.Normal)
        headButton.addTarget(self, action: #selector(self.selectImageForNote), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(headButton)
        
        tiltelTextView.frame = CGRectMake(65, 10, DEF_SCREEN_WIDTH-75, 45)
        tiltelTextView.font = UIFont.boldSystemFontOfSize(16.0)
        tiltelTextView.placeholder = "标题"
        
        self.view.addSubview(tiltelTextView)
        
        noteMessageTextView.frame = CGRectMake(0, tiltelTextView.frame.maxY + 10, DEF_SCREEN_WIDTH, 100)
        noteMessageTextView.font = UIFont.boldSystemFontOfSize(16.0)
        noteMessageTextView.delegate = self
        self.view.addSubview(noteMessageTextView)
        
        textViewLabel.frame = CGRectMake(10, 5, DEF_SCREEN_WIDTH - 30, 20)
        textViewLabel.font = UIFont.boldSystemFontOfSize(16.0)
        textViewLabel.textColor = getColor("A9A9A9")
        textViewLabel.text = "内容";
        noteMessageTextView.addSubview(textViewLabel)
        
        if isCreate == false {
            let data:NSData! = (baseNote! as Note).image!
            let dateNoImage = "noImage".dataUsingEncoding(NSUTF8StringEncoding)
            
            if !(data.isEqualToData(dateNoImage!)) {
                let image:UIImage = UIImage(data: (baseNote! as Note).image!)!
                headButton.setBackgroundImage(image, forState: UIControlState.Normal)
                _image = UIImage(data: (baseNote! as Note).image!)!
            }else{
                
                _image = nil
            }
            tiltelTextView.text = (baseNote! as Note).title as? String
            noteMessageTextView.text = (baseNote! as Note).content as? String
            textViewLabel.hidden = true
            
            let sigleTouch: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.endEdite))
            self.view.addGestureRecognizer(sigleTouch)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //MARK: UITextViewDelegate
    internal func textViewDidBeginEditing(textView: UITextView){
        textViewLabel.hidden = true;
    }
    
    internal func textViewDidEndEditing(textView: UITextView){
        if (strlen(textView.text as String) == 0) {
            textViewLabel.hidden = true;
        }
    }
    
    //MARK: EVENT
    func selectImageForNote(){
        self.showOkayCancelAlert()
    }
    
    @IBAction func saveThisNote(sender: AnyObject) {
        let note:Note = Note()
        note.title = tiltelTextView.text
        note.content = noteMessageTextView.text
        if _image != nil {
            note.image = UIImageJPEGRepresentation(_image, 0.0001)
        }else{
            note.image = "noImage".dataUsingEncoding(NSUTF8StringEncoding)
        }
        if (isCreate == true) {
            note.date = NSDate()
            NoteBl.createNote(note)
        }else{
            note.date = baseNote!.date
            NoteBl.chageNote(note)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func endEdite(){
        self.view.endEditing(true)
    }
    
    //MARK: Phote
    func showOkayCancelAlert() -> Void {
        let alertController:UIAlertController = UIAlertController(title: nil, message: nil,preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let takingAction = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler:{(action) in
            if (self.confirmCamera() == false){
                showMessage("摄像头不可用")
                return
            }
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        })
        
        let photoAction = UIAlertAction(title: "从相册中选择", style: UIAlertActionStyle.Default, handler:{(action) in
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePickerController.allowsEditing = true
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(takingAction)
        alertController.addAction(photoAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func confirmCamera() -> Bool {
        let mediaType = AVMediaTypeVideo
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(mediaType)
        if (authStatus == AVAuthorizationStatus.Restricted || authStatus == AVAuthorizationStatus.Denied) {
            print("相机权限受限")
            return false
        }
        return (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) && UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear))
    }
    
    internal func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var infoDic: NSDictionary
        infoDic = info
        let img: UIImage = infoDic.objectForKey(UIImagePickerControllerEditedImage) as! UIImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        _image = img
        headButton.setBackgroundImage(_image, forState: UIControlState.Normal)
    }
}
