//
//  FollowCollectionViewCell.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class FollowCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID = "FollowerCell"
    let usernameLabel = TitleLabel(textAlignment: .center, fontSize: 16)
    let avatarImageView = AvatarImageView(frame: .zero)
    
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follow: Follow) {
        
        usernameLabel.text = follow.username
        avatarImageView.downloadAvatarImage(from: follow.avatarUrl)
        
    }
    
    
    private func configure() {
        
        addSubviews(avatarImageView,
                    usernameLabel)
        
        let padding: CGFloat = 8
       
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
])
    }
}
