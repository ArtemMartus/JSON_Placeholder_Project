//
//  PhotoDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 20.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class PhotoDetailsView: UIViewController {
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var text = ""
    var image = UIImage()
    
    func configure(_ text: String, image: UIImage) {
        self.text = text
        self.image = image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelView.text = text
        imageView.image = image
    }
}
