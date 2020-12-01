//
//  FollowCollectionViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit


class FollowListViewController: DataLoadingViewController {
    
    enum Section {
        case main
    }
    
    // MARK: - Properties
    
    var type: FollowType!
    var follows: [Follow] = []
    var filteredFollows: [Follow] = []
    
    var username: String!
    var pageNumber = 1
    var filterd: String = ""
    
    var searchController: UISearchController!
    var collectionView: UICollectionView!
    var dataSoucre: UICollectionViewDiffableDataSource<Section,Follow>!
    
    var isLoading = false
    var isSearching = false
    var hasMoreFollowers = true
    
    
    // MARK: - Inits
    
    init(username: String, type: FollowType) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.type = type
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        title = username
        configureController()
        getFollow(type: type, pageNumber: pageNumber)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        configureBarButtonItem()
    }
    
    // MARK: - Configuration
    
    func configureController() {
        configureViewController()
        configureBarButtonItem()
        configureSearchController()
        configureCollectionView()
    }
    
    func configureSearchController() {
        searchController                                        = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UIHelpers.createThreeColumnFlowLayout(in: view))
        
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.register(FollowCollectionViewCell.self, forCellWithReuseIdentifier: FollowCollectionViewCell.reuseID)
    }
    
    func configureDataSource() {
        dataSoucre = UICollectionViewDiffableDataSource<Section,Follow>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follow) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowCollectionViewCell.reuseID, for: indexPath) as! FollowCollectionViewCell
            cell.set(follow: follow)
            return cell
        })
    }
    
    func configureBarButtonItem() {
        navigationItem.rightBarButtonItem = BookmarkBarButtonItem(for: username, in: self)
    }
   
    
    // MARK: - Helpers
    
    func updateData(on follows: [Follow]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follow>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follows)
        
        DispatchQueue.main.async {
            self.dataSoucre.apply(snapshot)
        }
        
    }
    
    func getFollow(type: FollowType, pageNumber: Int) {
        
        showLoadingView()
        isLoading = true
        
        NetworkManager.shared.getFollow(type: type, for: username, page: pageNumber) {[weak self] (result) in
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happend ", message: error.rawValue, buttonTile: "Ok")
            case .success(let follows):
                self.updateUI(with: follows)
            }
            
            self.isLoading = false
        }
        
    }
    
    
    func updateUI(with follows: [Follow]) {
        
        if follows.count < 100 { hasMoreFollowers = false }
        
        self.follows.append(contentsOf: follows)
        
        if self.follows.isEmpty {
            let message = "This user  doesn't have any \(type.rawValue). Go follow them 😀"
            DispatchQueue.main.async {
                self.showEmptySateView(with: message, in: self.view)
                return
            }
        }
        
        isSearching ? updateDataWithFilteredFollows() : self.updateData(on: self.follows)
        
    }
    
    
    func updateDataWithFilteredFollows() {
        filteredFollows = follows.filter({ (follow) -> Bool in
            follow.username.lowercased().contains(filterd.lowercased())
        })
        updateData(on: filteredFollows)
    }
}
// MARK: - Extension

extension FollowListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollows : follows
        let follower = activeArray[indexPath.item]
        let destinationVC = UserInfoViewController()
        destinationVC.username = follower.username
        destinationVC.delegate = self
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let heightOfScrollView = scrollView.frame.size.height
        
        if offsetY > contentHeight - heightOfScrollView && hasMoreFollowers  && !isLoading {
            pageNumber += 1
            getFollow(type: type, pageNumber: pageNumber)
        }
        
    }
    
}


extension FollowListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard searchController.searchBar.text != nil, !searchController.searchBar.text!.isEmpty else {
            filteredFollows.removeAll()
            isSearching = false
            updateData(on: follows)
            return
        }
        
        isSearching = true
        
        filterd = searchController.searchBar.text!
        updateDataWithFilteredFollows()
        
    }
    
}


extension FollowListViewController: UserInfoViewControllerDelegate {
    
    func didRequestFollow(for username: String, followType: FollowType) {
        
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        searchController.isActive = false
        
        follows.removeAll()
        filteredFollows.removeAll()
        
        self.username   = username
        title           = username
        
        type = followType
        pageNumber      = 1
        getFollow(type: type, pageNumber: pageNumber)
    }
    
}
