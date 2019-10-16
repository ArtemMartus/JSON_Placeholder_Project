//
//  Router.swift
//  Json Api Check
//
//  Created by Artem Martus on 16.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

enum RouteState {
    case usersList(view: UIViewController!)
    case userDetails(view: UIViewController!)
    case albumDetails(view: UIViewController!)
    case postDetails(view: UIViewController!)
    
    func get()->UIViewController!{
        switch self {
        case .usersList(let view):
            return view
        case .userDetails(let view):
            return view
        case .albumDetails(let view):
            return view
        case .postDetails(let view):
            return view
        }
    }
}

class Router {
    private(set) var rootView: UINavigationController!
    private var state: RouteState = .usersList(view: UsersListView())
        
    
    init() {
        rootView = UINavigationController(rootViewController: state.get())
    }
}
