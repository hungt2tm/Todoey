//
//  Item.swift
//  Todoey
//
//  Created by Do Hung on 9/27/19.
//  Copyright © 2019 Do Hung. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    
    var title: String
    var done: Bool
    
    init(title: String, done: Bool) {
        self.title = title
        self.done = done
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(done, forKey: "done")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: "title") as! String
        let done = aDecoder.decodeBool(forKey: "done")
        self.init(title: title, done: done)
    }
}
