//
//  Error.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit
enum CusError: String, Error {
    case invalidUsername = "This username created an invalid request"
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidReponse = "Invalid response from the sever"
    case invalidData =  "The data received from the sever was invalid"
    case unableToFavorite  = "There was error favoriting thi user. Please try again"
    case alreadyInFavoirtes = "You're already favorited this user"
}
