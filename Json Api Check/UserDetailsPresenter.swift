//
//  UserDetailsPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 23.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import RxSwift
import UIKit

protocol UDPresenter: UITableViewDelegate & UITableViewDataSource {
    func configure(with user: User)
}

class UserDetailsPresenter: NSObject ,UDPresenter {
    private var router: Router! { view.router }
    private weak var repository: RepositoryInteractor!
    private var postsSub: Disposable!
    private var albumsSub: Disposable!
    private let view: Reloadable!
    private var user: User!
    
    init(view: Reloadable!) {
        self.view = view
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
        
        super.init()
        
        postsSub = repository.posts.subscribe({
            [weak self] event in
            debugPrint("posts updated with event")
            guard let self = self else {return}
            self.view.reload()
        })
        albumsSub = repository.albums.subscribe({
            [weak self] event in
            debugPrint("albums updated with event")
            guard let self = self else {return}
            self.view.reload()
        })
    }
    
    func configure(with user: User){
        self.user = user
    }
    
    deinit {
        debugPrint("disposing posts sub")
        postsSub.dispose()
        debugPrint("disposing albums sub")
        albumsSub.dispose()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        if section == 1 {
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Posts"
        }
        if section == 1 {
            return "Albums"
        }
        return "Undefined"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: standardListCell)!
    }
    
}
