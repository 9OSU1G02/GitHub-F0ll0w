//
//  FavoritesManager.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/30/20.
//

import Foundation

enum FavoritesActionType {
    case add, remove
}

enum FavoritesManager {
    
    
    static func updateWith(favorite: Follow, actionType: FavoritesActionType, completed: @escaping (CusError?) -> Void) {
        
        retrieveFavorites { (result) in

            switch result {

            case .success(var favorites):
                switch actionType {

                case .add:
                    guard !isUserAlreadyInFavorites(username: favorite.username) else {
                        completed(.alreadyInFavoirtes)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { (followers) -> Bool in
                        followers.username == favorite.username
                    }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }

        }
        
    }
    
    
    static func retrieveFavorites(completed: @escaping ( Result<[Follow],CusError>) -> Void ) {
        
        guard let favoritesData = UserDefaults.standard.object(forKey: KEY_FAVORITES) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follow].self, from: favoritesData)
            completed(.success(favorites))
        }
        catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follow]) -> CusError? {
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            UserDefaults.standard.setValue(data, forKey: KEY_FAVORITES)
            NotificationCenter.default.post(name: Notification.Name(FAVORITES_CHANGE_NOTIFICATION), object: nil)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func isUserAlreadyInFavorites(username: String) -> Bool {
        
        var isAlreadyInFavorites = false
        retrieveFavorites { (result) in
            
            switch result {
            case .failure(_):
                isAlreadyInFavorites = false
            case .success(let favorites):
                for favorite in favorites {
                    if favorite.username.lowercased() == username.lowercased() {
                        isAlreadyInFavorites = true
                        break
                    }
                }
            }
            
        }
        return isAlreadyInFavorites
    }
    
}
