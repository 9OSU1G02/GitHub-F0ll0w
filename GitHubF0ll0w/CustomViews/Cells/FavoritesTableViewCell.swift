//
//  FavoritesTableViewCell.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/30/20.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let reuseID = "FavoritesCell"
    let usernameLabel = TitleLabel(textAlignment: .left, fontSize: 26)
    let avatarImageView = AvatarImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follow) {
        usernameLabel.text = favorite.username
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self](image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure() {
        addSubviews(usernameLabel,avatarImageView)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
