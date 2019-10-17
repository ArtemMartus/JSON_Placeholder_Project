//
//  RealmService.swift
//  Json Api Check
//
//  Created by Artem Martus on 17.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmService {
    private let realm: Realm
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Couldn't initialize realm database: \(error)")
        }
        debugPrint("Realm database initialized")
    }
}
