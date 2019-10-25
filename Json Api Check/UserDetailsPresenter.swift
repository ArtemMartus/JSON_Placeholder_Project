//
//  UserDetailsPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 23.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

protocol UDPresenter: UITableViewDelegate & UITableViewDataSource {
    func configure(with user: User!)
}

class UserDetailsPresenter: NSObject ,UDPresenter {
    private var router: Router! { view.router }
    private weak var repository: RepositoryInteractor!
    private let view: Reloadable!
    private var user: User!
    
    private var posts: Posts?
    private var albums: Albums?
    
    private var mainSectionData = [String]()
    
    private let idMain = 0
    private let idPosts = 1
    private let idAlbums = 2
    
    init(view: Reloadable!) {
        self.view = view
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
        
        super.init()
    }
    
    func configure(with user: User!){
        self.user = user
        mainSectionData.removeAll()

        if let website = user.website {
            mainSectionData.append("Website: " + website)
        }
        if let city = user.address?.city {
            mainSectionData.append("City: " + city)
        }
        if let suite = user.address?.suite {
            mainSectionData.append("Suite: " + suite)
        }
        if let street = user.address?.street {
            mainSectionData.append("Street: " + street)
        }
        if let zip = user.address?.zipcode {
            mainSectionData.append( "Zip-code: " + zip)
        }
        if let phone = user.phone {
            mainSectionData.append( "Phone: " + phone)
        }
        if let email = user.email {
            mainSectionData.append( "Email: " + email)
        }
        if let company = user.company?.name {
            mainSectionData.append( "Company: " + company)
        }
        
        repository.getPosts(uid: user.id){ [weak self] posts in
            self?.posts = posts
            self?.view.reload()
        }
        repository.getAlbums(uid: user.id){ [weak self] albums in
            self?.albums = albums
            self?.view.reload()
        }
        
        view.reload()
    }
    
    deinit {
        debugPrint("user details deinit")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case idMain:
                return mainSectionData.count
            case idPosts:
                return posts?.count ?? 1
            case idAlbums:
                return albums?.count ?? 1
            default:
                return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case idMain:
                return "Main information"
            case idPosts:
                return "Posts"
            case idAlbums:
                return "Albums"
            default:
                return "Undefined"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: standardListCell, for: indexPath)
        
        let row = indexPath.row
        let section = indexPath.section
        
        switch section {
            case idMain:
                cell.textLabel?.text = mainSectionData[row]
            case idPosts:
                if let post = posts?[row]{
                    cell.textLabel?.text = post.title
                } else {
                    cell.textLabel?.text = "No posts"
                }
            case idAlbums:
                if let post = albums?[row]{
                    cell.textLabel?.text = post.title
                } else {
                    cell.textLabel?.text = "No albums"
                }
            default:
                fatalError("No cell handler for \(section) section")
        }
        
        return cell
    }
    
}
