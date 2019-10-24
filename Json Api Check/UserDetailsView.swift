//
//  UserDetailsView.swift
//  Json Api Check
//
//  Created by Artem Martus on 16.10.2019.
//  Copyright © 2019 Artem Martus. All rights reserved.
//

import UIKit

class UserDetailsView: UIViewController, Reloadable {
    private lazy var presenter: UDPresenter! = UserDetailsPresenter(view: self)
    
    private var emailLabel = UILabel()
    private var addressLabel = UILabel()
    private var phoneLabel = UILabel()
    private var websiteLabel = UILabel()
    private var embedTable = EmbedUserDetailsView()
    
    
    var router: Router! { (view.window?.windowScene?.delegate as? SceneDelegate)?.router }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        debugPrint("user details view init()")
    }
    
    deinit {
        debugPrint("user details view deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    func setupLayout(){
        self.view.addSubview(emailLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(websiteLabel)
        self.addChild(embedTable)
        self.view.addSubview(embedTable.view)
        
        embedTable.view.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = self.view.layoutMarginsGuide
        var safe = self.view.safeAreaLayoutGuide
        var view: UIView! = emailLabel
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.topAnchor, constant: CGFloat(4)),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
        safe = view.safeAreaLayoutGuide
        view = addressLabel
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
        safe = view.safeAreaLayoutGuide
        view = phoneLabel
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
        safe = view.safeAreaLayoutGuide
        view = websiteLabel
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
        safe = view.safeAreaLayoutGuide
        view = embedTable.view
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: safe.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        embedTable.tableView.register(UITableViewCell.self, forCellReuseIdentifier: standardListCell)
        embedTable.tableView.delegate = presenter
        embedTable.tableView.dataSource = presenter
        embedTable.didMove(toParent: self)
    }
    
    func reload() {
        embedTable.tableView.reloadData()
    }
    
    func configure(_ item: User){
        // TODO: move data flow to presenter
        // TODO: show downloaded posts and albums
        presenter.configure(with: item)
        title = item.name
        
        if let website = item.website {
            websiteLabel.text = "Website: " + website
            websiteLabel.isHidden = false
        } else {
            websiteLabel.isHidden = true
        }
        
        if let city = item.address?.city, let suite = item.address?.suite, let street = item.address?.street {
            let address = suite+" "+city+" "+street
            addressLabel.text = "Address: " + address
            addressLabel.isHidden = false
        } else {
            addressLabel.isHidden = true
        }
        
        if let phone = item.phone {
            phoneLabel.text = "Phone: " + phone
            phoneLabel.isHidden = false
        } else {
            phoneLabel.isHidden = true
        }
        
        if let email = item.email {
            emailLabel.text = "Email: " + email
            emailLabel.isHidden = false
        } else {
            emailLabel.isHidden = true
        }
    }
}
