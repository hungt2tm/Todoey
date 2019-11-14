//
//  Item.swift
//  Todoey
//
//  Created by Do Hung on 11/13/19.
//  Copyright © 2019 Do Hung. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var createdDate: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
