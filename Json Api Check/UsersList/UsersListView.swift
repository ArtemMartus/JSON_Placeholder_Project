//
//  UsersListView.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class UsersListView: UIViewController {
    private lazy var presenter: ULPresenter! = UsersListPresenter()
    private lazy var tableView: UITableView! = UITableView(frame: view.frame)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    
        title = "Users"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UsersListCellView.self, forCellReuseIdentifier: cellIdentifiers.usersListCell.rawValue)
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        view.addSubview(tableView)
        view.backgroundColor = .yellow
    }
}
