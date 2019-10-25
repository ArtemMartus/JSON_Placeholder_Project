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
    private let realm: Realm!
    var users: BehaviorSubject<Users>!
    var posts: BehaviorSubject<Posts>!
    var albums: BehaviorSubject<Albums>!
    private var disposeBag: DisposeBag!
    
    init() {
        
        // remove old database while in debug phase
//        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do {
            realm = try Realm()
        } catch {
            fatalError("Couldn't initialize realm database: \(error)")
        }
        debugPrint("Realm database initialized")
        disposeBag = DisposeBag()
        
        loadUsers()
        loadPosts()
        loadAlbums()
    }
    
    deinit {
        debugPrint("Disposing realm service")
    }
    
    private func loadUsers(){
        debugPrint("Loading users from db...")
        users = BehaviorSubject(value: Array(realm.objects(User.self)))
        disposeBag.insert(
            users.subscribe({[weak self]event in
                if let error = event.error {
                    fatalError(error.localizedDescription)
                }
                
                try! self?.realm.write {
                    self?.realm.add(event.element!)
                }
                
                debugPrint("Added \(event.element!.count) users to database")
            })
        )
    }
    
    private func loadPosts(){
        debugPrint("Loading posts from db...")
        posts = BehaviorSubject(value: Array(realm.objects(Post.self)))
        disposeBag.insert(
            posts.subscribe({[weak self]event in
                if let error = event.error {
                    fatalError(error.localizedDescription)
                }
                
                try! self?.realm.write {
                    self?.realm.add(event.element!)
                }
                
                debugPrint("Added \(event.element!.count) posts to database")
            })
        )
    }
    
    private func loadAlbums(){
        debugPrint("Loading users from db...")
        albums = BehaviorSubject(value: Array(realm.objects(Album.self)))
        disposeBag.insert(
            albums.subscribe({[weak self]event in
                if let error = event.error {
                    fatalError(error.localizedDescription)
                }
                
                try! self?.realm.write {
                    self?.realm.add(event.element!)
                }
                
                debugPrint("Added \(event.element!.count) albums to database")
            })
        )
    }
}
