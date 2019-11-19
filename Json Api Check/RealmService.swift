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
import Dispatch

class RealmService {
    private var realm: Realm!
    
    init() {
        
        // remove old database while in debug phase
        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Couldn't initialize realm database: \(error)")
        }
        debugPrint("Realm database initialized")
        
        
    }
    
    public func writeUsers(_ array: Users) {
        if array.count == 0 { return }
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.add(array)
            }
            debugPrint("Added \(array.count) users to database")
        }
    }
    
    public func loadUsers() -> Users {
        debugPrint("Loading users from db...")
        return Array(realm.objects(User.self))
    }
    
    public func writePosts(_ array: Posts) {
        try! realm.write {
            realm.add(array)
        }
        debugPrint("Added \(array.count) posts to database")
    }
    
    public func loadPosts() -> Posts {
        debugPrint("Loading posts from db...")
        return Array(realm.objects(Post.self))
    }
    
    public func writeAlbums(_ array: Albums) {
        try! realm.write {
            realm.add(array)
        }
        debugPrint("Added \(array.count) Albums to database")
    }
    
    public func loadAlbums() -> Albums {
        debugPrint("Loading Albums from db...")
        return Array(realm.objects(Album.self))
    }
    
    public func writePhotos(_ array: Photos) {
        try! realm.write {
            realm.add(array)
        }
        debugPrint("Added \(array.count) Photos to database")
    }
    
    public func loadPhotos() -> Photos {
        debugPrint("Loading Photos from db...")
        return Array(realm.objects(Photo.self))
    }
}
