//
//  UsersListPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit
import RxSwift
import Dispatch

typealias ULPresenter = UITableViewDelegate & UITableViewDataSource

class UsersListPresenter: NSObject, ULPresenter {
    
    private weak var repository: RepositoryInteractor!
    private var sub: Disposable!
    private let reloadableView: Reloadable
    
    init(view: Reloadable) {
        reloadableView = view
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
        
        super.init()
        
        sub = repository.users.subscribe({
            [weak self] event in
            debugPrint("data updated with event")
            guard let self = self else {return}
            self.reloadableView.reload()
            })
    }
    
    deinit {
        debugPrint("disposing sub")
        sub.dispose()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var users: Users!
        do {
            users = try repository.users.value()
        } catch {
            fatalError("Couldn't retrieve data")
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: usersListCell, for: indexPath) as! UsersListCellView
        
        var users: Users!
        do {
            users = try repository.users.value()
        } catch {
            fatalError("Couldn't retrieve data")
        }
        
        cell.updateWith(user: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Selected row: \(indexPath.row)")
    }
}
