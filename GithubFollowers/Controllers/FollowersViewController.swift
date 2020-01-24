//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { [unowned self] (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGFAlertViewController(title: "Error fetching Data!", message: errorMessage!, buttonTitle: "OK")
                return
            }
            print("Followers.count: \(followers.count)\n")
            print(followers)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    
    

    

}
