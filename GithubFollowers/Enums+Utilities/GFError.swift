//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/24/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    //network call related errors
    case invalidUsername = "This username caused an invalid request. Please try again."
    case unableToComplete = "Unable to complete request. Please check internet connection."
    case invalidResposne = "Invalid response from server. Please try again."
    case invalidData = "Data from server was invalid. Please try again."
    
    //saving/loading favorite related errors
    case unableToAddFavorite = "Error adding user to Favorites."
    case unableToGetFavorite = "Error retrieving Favorites."
    case favoriteExists = "User already in Favorites."
}
