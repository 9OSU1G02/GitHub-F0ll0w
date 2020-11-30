//
//  Follow.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import Foundation

struct Follow: Codable, Hashable {
    var username: String
    var avatarUrl: String
    let id: Int
    var isAlreadyInFavorite: Bool {
        return FavoritesManager.idIsAlreadyInFavorites(id: id)
        }
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarUrl = "avatar_url"
        case id
    }
}
