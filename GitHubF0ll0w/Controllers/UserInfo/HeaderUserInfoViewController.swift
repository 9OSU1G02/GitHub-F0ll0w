//
//  HeaderUserInfoViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

class HeaderUserInfoViewController: UIViewController {
    // MARK: - Properties
    
    let avatarImageView     = AvatarImageView(frame: .zero)
    let usernameLabel       = TitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = SecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = SecondaryTitleLabel(fontSize: 18)
    let bioLabel            = BodyLabel(textAlignment: .left)
    
    var user: User!
    
    
    // MARK: - Inits
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(avatarImageView,
                         usernameLabel,
                         nameLabel,
                         locationImageView,
                         locationLabel,
                         bioLabel)
        layoutUI()
        configureUIElements()
    }
    
    // MARK: - Config
    
    func configureUIElements() {
        avatarImageView.downloadAvatarImage(from: user.avatarUrl)
        usernameLabel.text          = user.username
        nameLabel.text              = user.name ?? ""
        locationLabel.text          = user.location ?? "No Location"
        bioLabel.text               = user.bio ?? "No bio available"
        bioLabel.numberOfLines      = 3
        
        locationImageView.image     = SymbolImages.location
        locationImageView.tintColor = .secondaryLabel
    }
    
    // MARK: - Helpers
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)

        ])
    }
  

}
