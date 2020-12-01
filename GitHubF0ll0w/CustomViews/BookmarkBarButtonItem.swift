//
//  BookmarkBarButtonItem.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 12/1/20.
//

import UIKit

class BookmarkBarButtonItem: UIBarButtonItem {
    var username: String!
    var vc: DataLoadingViewController!
    
   
    init(for username: String, in vc: DataLoadingViewController) {
        super.init()
        self.username = username
        self.vc = vc
        configureBarButtonItem()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBarButtonItem() {
        let imageSystemName = FavoritesManager.isUserAlreadyInFavorites(username: username) ? "bookmark.fill" : "bookmark"
        image = UIImage(systemName: imageSystemName)
        style = .done
        target = nil
        action = #selector(bookmarksButtonTapped)
    }
    
    
    @objc func bookmarksButtonTapped() {
        vc.showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] (result) in
            guard let self = self else { return }
            self.vc.dismissLoadingView()
            switch result {
            case .success(let user):
                let actionType: FavoritesActionType = FavoritesManager.isUserAlreadyInFavorites(username: user.username) ? .remove : .add
                self.editUserWithFavorites(user: user,actionType: actionType)
            case .failure(let error):
                self.vc.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTile: "Ok")
            }
        }
    }
    
    
    func editUserWithFavorites(user: User, actionType: FavoritesActionType) {
        let favorite = Follow(username: user.username, avatarUrl: user.avatarUrl)
        FavoritesManager.updateWith(favorite: favorite, actionType: actionType) {[weak self] (error) in
            guard let self = self else { return }
            guard let error = error else {
                let message = actionType == .add ? "You have successfully favorited this user 🥳" : "You have successfully remove this user 🥳"
                self.vc.presentAlertOnMainThread(title: "Success!", message: message, buttonTile: "Ok")
                return
            }
            self.vc.presentAlertOnMainThread(title: "Some thing went wrong", message: error.rawValue, buttonTile: "Ok")
        }
        DispatchQueue.main.async {
            self.configureBarButtonItem()
        }
    }
    
}
