//
//  UserInfoViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

protocol UserInfoViewControllerDelegate: class {
    func didRequestFollow(for username: String, followType: FollowType)
}

class UserInfoViewController: DataLoadingViewController {
    
    // MARK: - Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    var username: String!
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews : [UIView] = []
    let dateLabel = BodyLabel(textAlignment: .center)
    
    weak var delegate: UserInfoViewControllerDelegate!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureScrollView()
        configureBarButtonItem()
        layoutUI()
        getUserInfo()
        setUpListenForFavoritesChange()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopListenForFavoritesChange()
    }
    
    
    // MARK: - Configure
    
    func configureBarButtonItem() {
        
        let bookmarksButton = BookmarkBarButtonItem(for: username, in: self)
        navigationItem.rightBarButtonItem = bookmarksButton
    }
        
    
    func configureUIElements(with user: User) {
        self.add(childVC: HeaderUserInfoViewController(user: user), to: headerView)
        self.add(childVC: RepoViewController(user: user,delegate: self), to: itemViewOne)
        self.add(childVC: FollowItemViewController(user: user,delegate: self), to: itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdge(of: view)
        contentView.pinToEdge(of: scrollView)
        
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    
    // MARK: - Notification
    func setUpListenForFavoritesChange() {
        NotificationCenter.default.addObserver(forName: Notification.Name(FAVORITES_CHANGE_NOTIFICATION), object: nil, queue: .main) { [weak self](_) in
            DispatchQueue.main.async {
                self?.configureBarButtonItem()
            }
        }
    }
    
    
    func stopListenForFavoritesChange() {
        removeObservers(names: Notification.Name(FAVORITES_CHANGE_NOTIFICATION), objcect: nil)
    }
    
    
    // MARK: - Helpres
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Some thing went wrong", message: error.rawValue, buttonTile: "Ok")
            }
        }
    }
    
    
    func layoutUI() {
        itemViews = [headerView,itemViewOne,itemViewTwo,dateLabel]
        let padding: CGFloat = 20
        let itemheight: CGFloat = 140
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemheight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemheight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        //child VC fill up entire containerView
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    // MARK: - Selectors
    @objc func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extension
extension UserInfoViewController: RepoViewControllerDelegate, FollowItemViewControllerDelegate {
    func didTapGoToGitHub(for user: User, type: GithubType) {
        
        guard let url = URL(string: user.htmlUrl + type.rawValue) else {
            presentAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTile: "Ok")
            return
        }
        presentSafariVC(url: url)
    }
    
    func didTapGetFollow(for user: User, type: FollowType) {
        
        var follow = 0
        
        switch type {
        
        case .follower:
            follow = user.followers
        case .following:
            follow = user.following
        }
        
        guard follow != 0 else { presentAlertOnMainThread(title: "No \(type.rawValue)", message: "This user has no \(type.rawValue). What a shame 🙁", buttonTile: "So sad")
            return
        }
        
        dismissVC()
        delegate.didRequestFollow(for: user.username, followType: type)
    }
}
