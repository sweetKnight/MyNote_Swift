//
//  NoteDAO.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/27.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class NoteDAO: NSObject {
    var listData: NSMutableArray!
    class func sharedManager()->NoteDAO{
        var instance:NoteDAO?
        var token: dispatch_once_t = 0
        dispatch_once(&token){
            instance = NoteDAO()
            instance?.createEditTableCopyOfDatabaseIfNeeded()
        }
        return instance!
    }
    
    func creat(model:Note!) -> Int {
        let path: NSString = self.applicationDDocumentsDirectoryFile()
        let array: NSMutableArray = NSMutableArray.init(contentsOfFile: path as String)!
        let note: NSDictionary = model.chageToDictionary()
        array.addObject(note)
        array.writeToFile(path as String, atomically: true)
        return 0
    }
    
    func remove(model:Note!) -> Int {
        let path: NSString = self.applicationDDocumentsDirectoryFile()
        let array: NSMutableArray = NSMutableArray.init(contentsOfFile: path as String)!
        for dict in array {
            let dictionary = dict
            if (dictionary.objectForKey("noteData") as! NSDate).isEqualToDate(model.date!) {
                array.removeObject(dict)
                array.writeToFile(path as String, atomically: true)
                return 0
            }
        }
        return 1;
    }
    func modify(model:Note) -> Int {
        let path: NSString = self.applicationDDocumentsDirectoryFile()
        let array: NSMutableArray = NSMutableArray.init(contentsOfFile: path as String)!
        for dict in array {
            let dictionary = dict
            if (dictionary.objectForKey("noteData") as! NSDate).isEqualToDate(model.date!) {
                dict.setValue(model.title, forKey: "noteTitle")
                dict.setValue(model.content, forKey: "noteContent")
                dict.setValue(model.image, forKey: "noteImage")
                array.writeToFile(path as String, atomically: true)
                return 0
            }
        }
        return 1
    }
    
    func findAll() -> NSMutableArray {
        let path: NSString = self.applicationDDocumentsDirectoryFile()
        let array: NSMutableArray = NSMutableArray.init(contentsOfFile: path as String)!
        let listArray:NSMutableArray = NSMutableArray()
        array.enumerateObjectsUsingBlock { (obj, idx, stop) in
            let dict: NSDictionary = obj as! NSDictionary
            let note:Note = Note()
            note.initWithDic(dict)
            listArray.addObject(note)
        }
        return listArray
    }
    
    func findById(note:Note) -> Note {
        let path: NSString = self.applicationDDocumentsDirectoryFile()
        let array: NSMutableArray = NSMutableArray.init(contentsOfFile: path as String)!
        for dict in array {
            if ((dict.objectForKey("dnoteDataate") as!NSDate) .isEqualToDate(note.date!)){
                let trueNote:Note = Note()
                trueNote.initWithDic(dict as! NSDictionary)
                return trueNote
            }
        }
        return Note()
    }
    
    //MARK: plistOperation
    
    func applicationDDocumentsDirectoryFile() -> NSString {
        let documentDirectory: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let path = documentDirectory[0].stringByAppendingPathComponent("NotesList.plist") as String
        var token: dispatch_once_t = 0
        dispatch_once(&token){
            print(path)
        }
        return path
    }
    
    func createEditTableCopyOfDatabaseIfNeeded() -> Void {
        let fileManage = NSFileManager.defaultManager()
        let writableDBPath:NSString! = self.applicationDDocumentsDirectoryFile()
        let dbexits:Bool = fileManage.fileExistsAtPath(writableDBPath as String)
        if !dbexits {
            let defaultDBPath = NSBundle.mainBundle().pathForResource("NotesList", ofType: "plist")
            do {
                try fileManage.copyItemAtPath(defaultDBPath!, toPath: writableDBPath as String)
            }catch{
                print("拷贝失败")
            }
        }
    }
}

