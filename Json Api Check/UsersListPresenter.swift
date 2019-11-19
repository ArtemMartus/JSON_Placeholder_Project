//
//  UsersListPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit
import Dispatch

typealias ULPresenter = UITableViewDelegate & UITableViewDataSource

class UsersListPresenter: NSObject, ULPresenter {
    private var users: Users?
    private var router: Router! { view.router }
    private weak var repository: RepositoryInteractor!
    private let view: Reloadable!
    
    init(view: Reloadable!) {
        self.view = view
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
        
        super.init()
        
        repository.getUsers {
            self.users = $0
            debugPrint("users updated with callback")
            self.view.reload()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: usersListCell, for: indexPath) as! UsersListCellView
        
        cell.updateWith(user: users![indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Selected row: \(indexPath.row)")
        
        let item: User = users![indexPath.row]
        //        debugPrint("User at row(\(indexPath.row)) equals \(item!)")
        router.userDetailsView.configure(item)
        router.navigation.pushViewController(router.userDetailsView, animated: true)
    }
}
