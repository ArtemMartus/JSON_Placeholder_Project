//
//  UsersListPresenter.swift
//  Json Api Check
//
//  Created by Artem Martus on 15.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

typealias ULPresenter = UITableViewDelegate & UITableViewDataSource

class UsersListPresenter: NSObject, ULPresenter {
    
    let testArray = ["Hello","Lovely","World"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers.usersListCell.rawValue) as! UsersListCellView
        cell.label.text = testArray[indexPath.row]
        return cell
    }
}
