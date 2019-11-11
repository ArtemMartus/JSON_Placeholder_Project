//
//  AlbumDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 20.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

// shows photos for specified album
class AlbumDetailsView: UIViewController, Reloadable {
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    private lazy var presenter: ADPresenter = AlbumDetailsPresenter(view: self)
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.register(AlbumDetailsCellView.self, forCellReuseIdentifier: albumsListCell)
        tableView!.dataSource = presenter
        tableView!.delegate = presenter
    }
    
    func configure(album: Album!) {
        title = album.title
        presenter.configure(with:  album)
    }
    
    func reload() {
        tableView?.reloadData()
    }
}
