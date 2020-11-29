//
//  ItemInfoView.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class ItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = TitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = TitleLabel(textAlignment: .center, fontSize: 14)
    
    // MARK: - View Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        addSubviews(symbolImageView,
                    titleLabel,
                    countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ])
    }
    
    func set(itemInfoType: ItemInfoType, withCount count:Int) {
        
        switch itemInfoType {
        case .followers:
            symbolImageView.image = SymbolImages.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SymbolImages.following
            titleLabel.text = "Following"
        case .repos:
            symbolImageView.image = SymbolImages.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SymbolImages.gists
            titleLabel.text = "Public Gists"
        }
        
        countLabel.text     = String(count)
    }
}
