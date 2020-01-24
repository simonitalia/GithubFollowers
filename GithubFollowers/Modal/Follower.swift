//
//  Follower.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/24/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

struct Follower: Codable {
    
    var login: String
    var avatarUrl: String
        //in json = avatar_url: converted automatically from by codable, from snake_case to camelCase
}
