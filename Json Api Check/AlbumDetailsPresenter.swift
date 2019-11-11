//
//  AlbumDetailsPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 10.11.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

protocol ADPresenter: UITableViewDelegate & UITableViewDataSource {
    func configure(with album: Album!)
}

class AlbumDetailsPresenter: NSObject, ADPresenter {
    private var router: Router! { view.router }
    private weak var repository: RepositoryInteractor!
    private var sub: Disposable!
    private let view: Reloadable!
    private var photos: Photos?
    
    init(view: Reloadable!) {
        self.view = view
        repository = (UIApplication.shared.delegate as! AppDelegate).repository
        
        super.init()
        
        sub = repository.albums.subscribe {
            [weak self] event in
            debugPrint("data updated with event")
            guard let self = self else {return}
            self.view.reload()
        }
    }
    
    deinit {
        debugPrint("disposing sub")
        sub.dispose()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: albumsListCell, for: indexPath) as! AlbumDetailsCellView
        
        
        let item = photos![indexPath.row]
        
        let resource = ImageResource(downloadURL: URL(string: item.thumbnailURL!)!)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
                case .success(let value):
                    if let cell = tableView.cellForRow(at: indexPath) {
                        cell.imageView?.image = value.image
                    }
//                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
        
        
        
        cell.updateWith(photo: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = photos![indexPath.row]

        let resource = ImageResource(downloadURL: URL(string: item.url!)!)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
                case .success(let value):
                    self.router.photoDetails.configure(item.title!, image: value.image)
                    self.router.navigation.pushViewController(self.router.photoDetails, animated: true)
                case .failure(let error):
                    print("Error: \(error)")
            }
        }
    }
    
    
    func configure(with album: Album!) {
        repository.getPhotos(albumID: album.id) {[weak self] array in
            self?.photos = array
            self?.view.reload()
        }
    }
    
}
