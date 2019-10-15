//
//  UserData.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation

class UserData {
    var name: String
    var age: UInt
    
    internal init(name: String, age: UInt) {
        self.name = name
        self.age = age
    }
}
