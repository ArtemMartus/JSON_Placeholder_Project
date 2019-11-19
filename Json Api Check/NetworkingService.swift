//
//  NetworkingService.swift
//  Json Api Check
//
//  Created by Artem Martus on 17.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingService {
    let root = "https://jsonplaceholder.typicode.com/"
    init() {
        debugPrint("Networking service initialized")
    }
    
    func updateUsers(_ callback: @escaping (Users)->Void) {
        Alamofire.request(root + "users").responseUsers { response in
            debugPrint("users response downloaded")
            if let data = response.result.value {
                debugPrint("passsing users data to subject")
                // UsersListPresenter must handle this
                callback(data)
            }
        }
    }
    
    func updatePosts(_ callback: @escaping (Posts)->Void) {
        Alamofire.request(root + "posts").responsePosts { response in
            debugPrint("posts response downloaded")
            if let data = response.result.value {
                debugPrint("passsing posts data to subject")
                // UserDetailsPresenter must handle this
                callback(data)
            }
        }
    }
    
    func updateAlbums(_ callback: @escaping (Albums)->Void) {
        Alamofire.request(root + "albums").responseAlbums { response in
            debugPrint("albums response downloaded")
            if let data = response.result.value {
                debugPrint("passsing albums data to subject")
                // UserDetailsPresenter must handle this
                callback(data)
            }
        }
    }
    
    func updatePhotos(_ callback: @escaping (Photos)->Void) {
        Alamofire.request(root + "photos").responsePhotos { response in
            debugPrint("photos response downloaded")
            if let data = response.result.value {
                debugPrint("passsing photoss data to subject")
                // UserDetailsPresenter must handle this
                callback(data)
            }
        }
    }
}
