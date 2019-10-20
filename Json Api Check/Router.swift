//
//  Router.swift
//  Json Api Check
//
//  Created by Artem Martus on 16.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

enum RouteState {
    case usersList
    case userDetails
    case albumDetails
    case postDetails
}

class Router {
    private(set) var viewController: UINavigationController!
    private var state: RouteState = .usersList
    
    private(set) lazy var usersListView = UsersListView()
    private(set) lazy var userDetailsView = UserDetailsView()
    
    private(set) lazy var navigation = UINavigationController()
    
    
    func setUp(_ window: UIWindow!){
        navigation.viewControllers = [usersListView]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
    
}
