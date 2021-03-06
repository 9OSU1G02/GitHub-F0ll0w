//
//  NetworkManager.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

enum FollowType: String {
    case follower = "followers"
    case following = "following"
}

enum GithubType: String {
    case profile = ""
    case repos = "?tab=repositories"
}

class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    //key: url of image, key : UIImage , cache work just like user default
    let cache = NSCache<NSString,UIImage>()
    
    
    // MARK: - Init
    private init () {}
    
    
    // MARK: - Method
    
    func getFollow(type: FollowType, for username: String,  page: Int, completion: @escaping (Result<[Follow],CusError>)-> Void ) {
        
        let endpoint = baseURL + "\(username)/\(type.rawValue)?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let reponse = reponse as? HTTPURLResponse, reponse.statusCode == 200 else {
                completion(.failure(.invalidUsername))
                return
            }
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let follows = try decoder.decode([Follow].self, from: data)
                completion(.success(follows))
            }
            catch {
                completion(.failure(.invalidData))
            }
            
        }
        
        task.resume()
        
    }
    
    
    func getUserInfo(for username: String, completed: @escaping (Result<User,CusError>) -> Void) {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, reponse, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            //Check if server reponse HTTP and status code = 200 (success)
            guard let response = reponse as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidReponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.unableToComplete))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                // json createdAt is iso8601 format
                decoder.dateDecodingStrategy = .iso8601
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }
            catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: url)
        //if image already in cache
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, reponse, error) in
            
            guard let self = self,
                  let data = data, let image = UIImage(data: data),
                  let reponse = reponse as? HTTPURLResponse, reponse.statusCode == 200,
                  error == nil
            else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        task.resume()
    }
    
}
