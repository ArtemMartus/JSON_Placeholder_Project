//
//  PostDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 10.11.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class PostDetailsView: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var contentView: UILabel!
    
    var label = "Title"
    var content = "Content"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        labelView.text = label
        contentView.text = content
    }


    func configure(label: String, content: String) {
        self.label = label
        self.content = content
    }
}
