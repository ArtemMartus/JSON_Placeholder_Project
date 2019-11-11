//
//  RepositoryInteractor.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class RepositoryInteractor {
    private let realm: RealmService
    private let network: NetworkingService
    
    var users: BehaviorSubject<Users> {
        return realm.users
    }
    
    var posts: BehaviorSubject<Posts> {
        return realm.posts
    }
    
    var albums: BehaviorSubject<Albums> {
        return realm.albums
    }
    
    var photos: BehaviorSubject<Photos> {
        return realm.photos
    }
    
    init() {
        network = NetworkingService()
        realm = RealmService()
        
        if try! users.value().count == 0 {
            debugPrint("Fetching users from internet...")
            network.updateUsers(users)
        }
        if try! posts.value().count == 0 {
            debugPrint("Fetching posts from internet...")
            network.updatePosts(posts)
        }
        if try! albums.value().count == 0 {
            debugPrint("Fetching albums from internet...")
            network.updateAlbums(albums)
        }
        if try! photos.value().count == 0 {
            debugPrint("Fetching photos from internet...")
            network.updatePhotos(photos)
        }
    }
    
    func getPosts(uid: Int,_ callback: @escaping (Posts)->Void) {
        let array = (try! posts.value()).filter{$0.userID == uid}
        callback( array )
    }
    
    func getAlbums(uid: Int,_ callback: @escaping (Albums)->Void) {
        let array = (try! albums.value()).filter{$0.userID == uid}
        callback( array )
    }
    
    func getPhotos(albumID: Int,_ callback: @escaping (Photos)->Void) {
        let array = (try! photos.value()).filter{$0.albumID == albumID}
        callback( array )
    }
}
