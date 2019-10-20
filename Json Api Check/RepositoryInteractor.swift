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
    
    
    init() {
        network = NetworkingService()
        realm = RealmService()
        
        if try! users.value().count == 0 {
            network.updateUsers(users)
        }
    }
    
}
