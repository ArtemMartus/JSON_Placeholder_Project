//
//  AlbumDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 20.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

// shows photos for specified album
class AlbumDetailsView: UIViewController {
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    private weak var repository = (UIApplication.shared.delegate as! AppDelegate).repository
    private var cellReuseIdentifier = albumsListCell
    private var photos: Photos?
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView!.register(UITableViewCell.self , forCellReuseIdentifier: cellReuseIdentifier)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.rowHeight = CGFloat(150)
    }
    
    func configure(album: Album!) {
        repository?.getAlbumPhotos(albumID: album.id) {
            self.title = album.title
            self.cellReuseIdentifier = albumsListCell + album.title!
            self.tableView?.register(UITableViewCell.self , forCellReuseIdentifier: self.cellReuseIdentifier)
            self.photos = $0
            self.tableView?.reloadData()
        }
    }
}


extension AlbumDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
}

extension AlbumDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = photos![indexPath.row]
        let cell = tableView
            .dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.imageView?.image = nil
        cell.textLabel?.text = nil
        
        cell.textLabel?.numberOfLines = 0
        
        
        repository?.downloadImage(item.thumbnailURL!) {
            if let searchCell = tableView.cellForRow(at: indexPath) {
                searchCell.imageView?.image = $0
                searchCell.textLabel?.text = item.title
            } else {
                cell.imageView?.image = $0
                cell.textLabel?.text = item.title
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = photos![indexPath.row]
        
        repository?.downloadImage(item.url!) {
            self.router.photoDetails.configure(item.title!, image: $0)
            self.router.navigation.pushViewController(self.router.photoDetails, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

