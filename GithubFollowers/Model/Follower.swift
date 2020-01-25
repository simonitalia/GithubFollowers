//
//  Follower.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/24/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable { //both properties conforom to Hashable property, for use with  diffableDataSource
    
    var login: String
    var avatarUrl: String
        //will convert from snake_case to camelCase when invoking JSONDecoder()
}
