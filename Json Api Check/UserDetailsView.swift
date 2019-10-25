//
//  UserDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 16.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class UserDetailsView: UIViewController, Reloadable {
    private lazy var presenter: UDPresenter! = UserDetailsPresenter(view: self)
    
    private var embedTable = EmbedUserDetailsView()
    
    
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        debugPrint("user details view init()")
    }
    
    deinit {
        debugPrint("user details view deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    func setupLayout(){
        let view = embedTable.view!
        let safe = self.view.safeAreaLayoutGuide

        self.addChild(embedTable)
        self.view.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.topAnchor),
            view.leadingAnchor.constraint(equalTo: safe.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: safe.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        embedTable.tableView.register(UITableViewCell.self, forCellReuseIdentifier: standardListCell)
        embedTable.tableView.delegate = presenter
        embedTable.tableView.dataSource = presenter
        embedTable.didMove(toParent: self)
    }
    
    func reload() {
        embedTable.tableView.reloadData()
    }
    
    func configure(_ item: User!){
        title = item.name ?? "User details"
        presenter.configure(with: item)
    }
}
