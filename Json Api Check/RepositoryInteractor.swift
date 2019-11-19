//
//  RepositoryInteractor.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import Dispatch

class RepositoryInteractor {
    private let realm: RealmService
    private let network: NetworkingService
    
    public func getUsers(_ callback: @escaping (Users)->Void) {
        let users = realm.loadUsers()
        if users.count == 0 {
            network.updateUsers {
                self.realm.writeUsers($0)
                callback($0);
            }
        }
        callback(users)
    }
    
    public func getPosts(_ callback: @escaping (Posts)->Void) {
        let posts = realm.loadPosts()
        if posts.count == 0 {
            network.updatePosts {
                self.realm.writePosts($0)
                callback($0);
            }
        }
        callback(posts)
    }
    
    public func getAlbums(_ callback: @escaping (Albums)->Void) {
        let albums = realm.loadAlbums()
        if albums.count == 0 {
            network.updateAlbums {
                self.realm.writeAlbums($0)
                callback($0);
            }
        }
        callback(albums)
    }
    
    public func getPhotos(_ callback: @escaping (Photos)->Void) {
        let photos = realm.loadPhotos()
        if photos.count == 0 {
            network.updatePhotos {
                self.realm.writePhotos($0)
                callback($0);
            }
        }
        callback(photos)
    }
    
    init() {
        network = NetworkingService()
        realm = RealmService()
    }
    
    func downloadImage(_ urlString: String, callback: @escaping (UIImage)->Void) {
        DispatchQueue.global().async {
            let cache = NSCache<NSString,UIImage>()
            if let image = cache.object(forKey: NSString(string: urlString)) {
                DispatchQueue.main.async {
                    callback(image)
                }
            } else {
                let task = URLSession.shared.dataTask(with: URL(string: urlString)!) {
                    data, response, error in
                    if let error = error {
                        print("downloading image \(error)")
                        return
                    }
                    let image = UIImage(data: data!)!
                    cache.setObject(image ,forKey: urlString as NSString)
                    DispatchQueue.main.async {
                        callback(image)
                    }
                }
                task.resume()
            }
        }
    }
    
    func getUserPosts(uid: Int,_ callback: @escaping (Posts)->Void) {
        getPosts { callback( $0.filter{$0.userID == uid} ) }
    }
    
    func getUserAlbums(uid: Int,_ callback: @escaping (Albums)->Void) {
        getAlbums { callback( $0.filter{$0.userID == uid} ) }
    }
    
    func getAlbumPhotos(albumID: Int,_ callback: @escaping (Photos)->Void) {
        getPhotos { callback( $0.filter{$0.albumID == albumID} ) }
    }
}
