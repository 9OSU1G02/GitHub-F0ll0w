//
//  FollowItemViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

protocol FollowItemViewControllerDelegate: class {
    func didTapGetFollow(for user: User, type: FollowType)
    
}

class FollowItemViewController: ItemInfoViewController {
    
    weak var delegate: FollowItemViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    init(user: User, delegate: FollowItemViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(background: .systemGreen, title: "Get Followers")
        actionButton2.set(background: .systemPurple, title: "Get Following")
    }
    
    override func actionButtonTapped(_ button: UIButton) {
        
        let type: FollowType = button == actionButton ? .follower : .following
        
        delegate.didTapGetFollow(for: user, type: type)
    }
  
}
