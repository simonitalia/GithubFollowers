//
//  CacheManager.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/26/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

struct CacheManager {
    static let shared = CacheManager()
    let imageCache = NSCache<NSString, UIImage>()
}
