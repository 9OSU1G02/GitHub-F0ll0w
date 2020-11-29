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
    var username: String!
    
    var type: FollowType!
    
    var follows: [Follow] = []
    var filteredFollows: [Follow] = []
    
    var pageNumber = 1
    
    var searchController: UISearchController!
    
    var collectionView: UICollectionView!
    
    var dataSoucre: UICollectionViewDiffableDataSource<Section,Follow>!
    
    var isLoading = false
    var isSearching = false
    var hasMoreFollowers = true
    
    var filterd: String = ""
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
        
        configureController()
        getFollow()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    // MARK: - Configuration
    
    func configureController() {
        configureViewController()
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
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
       
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.createThreeColumnFlowLayout(in: view))
        
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
    
    func updateData(on follows: [Follow]) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follow>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follows)
        
        DispatchQueue.main.async {
            self.dataSoucre.apply(snapshot)
        }
        
    }
    
    // MARK: - Selectors
    
    @objc func addButtonTapped() {
        
    }
    
    
    // MARK: - Helpers
     func getFollow() {
        
        NetworkManager.shared.getFollow(type: type, for: username, page: pageNumber) {[weak self] (result) in
            
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.rawValue)
            case .success(let follows):
                self.updateUI(with: follows)
            }
        }
       
    }
    
    
    func updateUI(with follows: [Follow]) {
        
        if follows.count < 100 { hasMoreFollowers = false }
        
        self.follows.append(contentsOf: follows)
        
        if self.follows.isEmpty {
            let message = "This user  doesn't have any followers. Go follow them 😀"
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let heightOfScrollView = scrollView.frame.size.height
        
        if offsetY > contentHeight - heightOfScrollView && hasMoreFollowers {
            pageNumber += 1
            getFollow()
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
        
        filterd = searchController.searchBar.text!
       
        isSearching = true
        updateDataWithFilteredFollows()
        
    }
    
}


