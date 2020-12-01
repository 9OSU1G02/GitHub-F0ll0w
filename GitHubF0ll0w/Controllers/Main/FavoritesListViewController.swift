//
//  FavoritesListViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class FavoritesListViewController: DataLoadingViewController {

    let tableView = UITableView()
    var favorites : [Follow] = []
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFovorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFovorites()
    }
    
    
    
    // MARK: - Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.removeExcessCells()
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.reuseID)
    }
    
    // MARK: - Helpers
    func getFovorites() {
        FavoritesManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTile: "Ok")
            }
        }
    }
    
    func updateUI(with favorites: [Follow]) {
        self.favorites = favorites
        if favorites.isEmpty {
            self.showEmptySateView(with: "No Favorites?\nAdd one on the follower screen", in: self.view)
        }
        else {
            //show tableview first
            self.view.bringSubviewToFront(self.tableView)
        }
        self.tableView.reloadData()
    }
}

// MARK: - Extension

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.reuseID, for: indexPath) as! FavoritesTableViewCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite = favorites[indexPath.row]
        
        let destinationVC = UserInfoViewController()
        destinationVC.username = favorite.username
        destinationVC.delegate = self
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let favorite = favorites[indexPath.row]
        FavoritesManager.updateWith(favorite: favorite, actionType: .remove) {[weak self] (error) in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                return }
            self.presentAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTile: "Ok")
        }
    }
}

extension FavoritesListViewController: UserInfoViewControllerDelegate {
    func didRequestFollow(for username: String, followType: FollowType) {
        let FollowListVC = FollowListViewController(username: username, type: followType)
        navigationController?.pushViewController(FollowListVC, animated: true)
    }
}
