//
//  NetworkingService.swift
//  Json Api Check
//
//  Created by Artem Martus on 17.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Dispatch

class NetworkingService {
    let root = "https://jsonplaceholder.typicode.com/"
    init() {
        debugPrint("Networking service initialized")
    }
    
    func updateUsers(_ callback: @escaping (Users)->Void) {
        URLSession.shared.dataTask(with: URL(string: root + "users")!, completionHandler: {
            data, response, error in
            if let error = error {
                print("downloading users \(error)")
                return
            }
            DispatchQueue.main.async {
                callback(try! JSONDecoder().decode(Users.self, from: data!))
            }
        }).resume()
    }
    
    func updatePosts(_ callback: @escaping (Posts)->Void) {
        URLSession.shared.dataTask(with: URL(string: root + "posts")!, completionHandler: {
            data, response, error in
            if let error = error {
                print("downloading posts \(error)")
                return
            }
            DispatchQueue.main.async {
                callback(try! JSONDecoder().decode(Posts.self, from: data!))
            }
        }).resume()
    }
    
    func updateAlbums(_ callback: @escaping (Albums)->Void) {
        URLSession.shared.dataTask(with: URL(string: root + "albums")!, completionHandler: {
            data, response, error in
            if let error = error {
                print("downloading albums \(error)")
                return
            }
            DispatchQueue.main.async {
                callback(try! JSONDecoder().decode(Albums.self, from: data!))
            }
        }).resume()
    }
    
    func updatePhotos(_ callback: @escaping (Photos)->Void) {
        URLSession.shared.dataTask(with: URL(string: root + "photos")!, completionHandler: {
            data, response, error in
            if let error = error {
                print("downloading photos \(error)")
                return
            }
            DispatchQueue.main.async {
                callback(try! JSONDecoder().decode(Photos.self, from: data!))
            }
        }).resume()
    }
}
