//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        DataPersistenceManager.getSavedFavorites { (result) in
            switch result {
            case .success(let favorites):
                print("Get Favorites successful.\nSaved Favorites: \(favorites.count)\nFavorites contents\(favorites)\n")
                
            case .failure(let error):
                break
            }
        }
    }
}

