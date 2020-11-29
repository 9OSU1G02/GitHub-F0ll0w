//
//  AvatarImageView.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class AvatarImageView: UIImageView {

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false

        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.placeholder
        
    }
    
    func downloadAvatarImage(from url: String) {
        NetworkManager.shared.downloadImage(from: url) {[weak self] (avatarImage) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = avatarImage
            }
        }
    }
}
