//
//  UsersListView.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

protocol Reloadable {
    func reload()
    var router: Router! {get}
}


class UsersListView: UIViewController, Reloadable {
    private lazy var presenter: ULPresenter! = UsersListPresenter(view: self)
    private lazy var tableView: UITableView! = UITableView(frame: view.frame)
    
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        debugPrint("users list view init()")
        title = "Users"
    }
    
    deinit {
        debugPrint("users list view deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UsersListCellView.self, forCellReuseIdentifier: usersListCell)
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        view.addSubview(tableView)
        view.backgroundColor = .yellow
    }
    
    func reload() {
        tableView.reloadData()
    }
}
