//
//  NoteBl.swift
//  MyNote_Swift
//
//  Created by 冯剑锋 on 16/3/28.
//  Copyright © 2016年 冯剑锋. All rights reserved.
//

import UIKit

class NoteBl: NSObject {
    class func createNote(model:Note) ->NSMutableArray{
        let dao:NoteDAO = NoteDAO.sharedManager()
        dao.creat(model)
        return dao.findAll()
    }
    
    class func remove(model:Note) ->NSMutableArray{
        let dao:NoteDAO = NoteDAO.sharedManager()
        dao.remove(model)
        return dao.findAll()
    }
    
    class func findAll() ->NSMutableArray{
        let dao:NoteDAO = NoteDAO.sharedManager()
        return dao.findAll()
    }
    
    class func chageNote(model:Note) ->NSMutableArray{
        let dao:NoteDAO = NoteDAO.sharedManager()
        dao.modify(model)
        return dao.findAll()
    }
    
}
