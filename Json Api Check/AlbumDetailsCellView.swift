//
//  AlbumDetailsCell.swift
//  Json Api Check
//
//  Created by Artem Martus on 10.11.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit
import Kingfisher

class AlbumDetailsCellView: UITableViewCell {
    
    func updateWith(photo: Photo!) {
        textLabel!.text = photo.title
        imageView?.kf.indicatorType = .activity
//        imageView?.kf.setImage(with: URL(string: photo.thumbnailURL!))
    }
}
