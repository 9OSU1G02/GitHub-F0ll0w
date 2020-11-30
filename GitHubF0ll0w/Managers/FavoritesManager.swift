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
                    //Check if that user is alreadly in favorite was saved in userDefault or not
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavoirtes)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { (followers) -> Bool in
                        followers.id == favorite.id
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
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    static func idIsAlreadyInFavorites(id: Int) -> Bool {
        var isAlreadyInFavorites = false
        retrieveFavorites { (result) in
            switch result {
            
            case .failure(_):
                isAlreadyInFavorites = false
            case .success(let favorites):
                for favorite in favorites {
                    if favorite.id == id {
                        isAlreadyInFavorites = true
                        break
                    }
                }
                
            }
        }
        return isAlreadyInFavorites
    }
    
}