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
    private var photos: Photos?
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView!.register(AlbumDetailsViewCell.self , forCellReuseIdentifier: albumsListCell)
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.rowHeight = CGFloat(150)
    }
    
    func configure(album: Album!) {
        repository?.getAlbumPhotos(albumID: album.id) {
            self.title = album.title
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

fileprivate  func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

extension AlbumDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = photos![indexPath.row]
        let raysImage = resizeImage(image: UIImage(systemName: "rays")!, targetSize: CGSize(width: 148, height: 148))
        let cell = tableView
            .dequeueReusableCell(withIdentifier: albumsListCell, for: indexPath) as! AlbumDetailsViewCell
        
        cell.imageView?.image = raysImage
        cell.photo = item
        cell.textLabel?.text = item.title
        cell.textLabel?.numberOfLines = 0
        
        
        repository?.downloadImage(item.thumbnailURL!) {
            if let rawCell = tableView.cellForRow(at: indexPath),
                let cell = rawCell as? AlbumDetailsViewCell,
                let photo = cell.photo,
                photo.id == item.id {
                
                cell.imageView?.image = $0
                
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

