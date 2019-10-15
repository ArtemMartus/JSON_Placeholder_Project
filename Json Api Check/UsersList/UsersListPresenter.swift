//
//  UsersListPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

typealias ULPresenter = UITableViewDelegate & UITableViewDataSource

class UsersListPresenter: NSObject, ULPresenter {
    
    private weak var repository: RepositoryInteractor!
    
    override init() {
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: usersListCell, for: indexPath) as! UsersListCellView
        
        cell.updateWith(user: repository.usersList[indexPath.row])
    
        return cell
    }
}
