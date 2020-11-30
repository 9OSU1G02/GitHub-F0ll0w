//
//  User.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

struct User: Codable {
    let username: String
    let avatarUrl: String
    var name: String?
    let id: Int
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    let htmlUrl:String
    var isAlreadyInFavorite: Bool {
        return FavoritesManager.idIsAlreadyInFavorites(id: id)
    }
    enum CodingKeys: String, CodingKey {
        case username =  "login"
        case avatarUrl
        case name
        case id
        case location
        case bio
        case publicRepos
        case publicGists
        case followers
        case following
        case createdAt
        case htmlUrl
    }
}
