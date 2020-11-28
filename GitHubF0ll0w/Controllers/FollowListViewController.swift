//
//  FollowCollectionViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit


class FollowListViewController: UIViewController {
    
    enum Section {
        case main
    }
    // MARK: - Properties
    var username: String!
    
    var type: FollowType!
    
    var follows: [Follow] = []
    
    var pageNumber = 1
    
    var searchController: UISearchController!
    
    var collectionView: UICollectionView!
    
    var dataSoucre: UITableViewDiffableDataSource<Section,Follow>!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    // MARK: - Configuration
    
    func configureController() {
        configureSearchController()
        configureViewController()
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
        
        collectionView.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        
        collectionView.register(FollowCollectionViewCell.self, forCellWithReuseIdentifier: FollowCollectionViewCell.reuseID)
    }
    
    
    
    // MARK: - Selectors
    
    @objc func addButtonTapped() {
        
    }
    
    

    
    // MARK: - Helpers
    private func getFollow() {
        NetworkManager.shared.getFollow(type: type, for: username, page: pageNumber) {[weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.rawValue)
            case .success(let follows):
                self.follows = follows
            }
        }
       
    }
    
}

// MARK: - Extension

extension FollowListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("")
    }
    
}
