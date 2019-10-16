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
    private(set) var users = BehaviorSubject<Users>(value:
        [User(id: 0, name: "No internet", username: "", email: "", address: nil, phone: "", website: "", company: nil)]
    )
    
    
    init() {
        Alamofire.request("https://jsonplaceholder.typicode.com/users").responseUsers { response in
            print("response downloaded")
            if let users = response.result.value {
                print("passsing data to subject")
                // UsersListPresenter must handle this
                self.users.onNext(users)
            }
        }
    }
    
}
