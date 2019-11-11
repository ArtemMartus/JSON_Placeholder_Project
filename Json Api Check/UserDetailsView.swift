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
    
    @IBOutlet weak var embedTable: UITableView?
    
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    
    deinit {
        debugPrint("user details view deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedTable!.register(UITableViewCell.self, forCellReuseIdentifier: standardListCell)
        embedTable!.delegate = presenter
        embedTable!.dataSource = presenter
    }
    
    
    func reload() {
        embedTable?.reloadData()
    }
    
    func configure(_ item: User!) {
        title = item.name ?? "User details"
        presenter.configure(with: item)
    }
}
