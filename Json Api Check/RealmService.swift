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
import RxSwift

class RealmService {
    private let realm: Realm
    let users: BehaviorSubject<Users>
    private var sub: Disposable!
    
    init() {
        
        // remove old database while in debug phase
//        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
         
        
        do {
            realm = try Realm()
        } catch {
            fatalError("Couldn't initialize realm database: \(error)")
        }
        debugPrint("Realm database initialized")
        
        debugPrint("Loading users from db...")
        users = BehaviorSubject(value: Array(realm.objects(User.self)))
        sub = users.subscribe({[weak self]event in
            if let error = event.error {
                fatalError(error.localizedDescription)
            }
            
            try! self?.realm.write {
                self?.realm.add(event.element!)
            }
            
            debugPrint("Added \(event.element!.count) users to database")
            })
    }
    
    deinit {
        debugPrint("Disposing sub")
        sub.dispose()
    }
}
