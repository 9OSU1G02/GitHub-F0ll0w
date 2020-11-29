//
//  RepoViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

protocol RepoViewControllerDelegate: class {
    func didTapGoToGitHub(for user: User, type: GithubType)
}

class RepoViewController: ItemInfoViewController {
    weak var delegate: RepoViewControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    init(user: User, delegate: RepoViewControllerDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .gists, withCount: user.publicGists)
        itemInfoViewTwo.set(itemInfoType: .repos, withCount: user.publicRepos)
        actionButton.set(background: .systemGreen, title: "GitHub Profile")
        actionButton2.set(background: .systemPurple, title: "GitHub Repository")
    }
    
    override func actionButtonTapped(_ button: UIButton) {
        
        let type: GithubType = button == actionButton ? .profile : .repos
        
        delegate.didTapGoToGitHub(for: user,type: type)
    }
    
}
