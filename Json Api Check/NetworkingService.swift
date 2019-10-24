//
//  NetworkingService.swift
//  Json Api Check
//
//  Created by Artem Martus on 17.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class NetworkingService {
    let root = "https://jsonplaceholder.typicode.com/"
    init() {
        debugPrint("Networking service initialized")
    }
    
    func updateUsers(_ users: BehaviorSubject<Users>){
        Alamofire.request(root + "users").responseUsers { response in
            debugPrint("users response downloaded")
            if let data = response.result.value {
                debugPrint("passsing users data to subject")
                // UsersListPresenter must handle this
                users.onNext(data)
            }
        }
    }
    
    func updatePosts(_ posts: BehaviorSubject<Posts>){
        Alamofire.request(root + "posts").responsePosts { response in
            debugPrint("posts response downloaded")
            if let data = response.result.value {
                debugPrint("passsing posts data to subject")
                // UserDetailsPresenter must handle this
                posts.onNext(data)
            }
        }
    }
    
    func updateAlbums(_ albums: BehaviorSubject<Albums>){
        Alamofire.request(root + "albums").responseAlbums { response in
            debugPrint("albums response downloaded")
            if let data = response.result.value {
                debugPrint("passsing albums data to subject")
                // UserDetailsPresenter must handle this
                albums.onNext(data)
            }
        }
    }
}
