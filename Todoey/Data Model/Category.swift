//
//  Category.swift
//  Todoey
//
//  Created by Do Hung on 11/13/19.
//  Copyright © 2019 Do Hung. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
