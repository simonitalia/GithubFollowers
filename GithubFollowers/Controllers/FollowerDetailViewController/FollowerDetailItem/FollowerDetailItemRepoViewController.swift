//
//  FollowerDetailItemRepoViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/29/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerDetailItemRepoViewController: FollowerDetailItemViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: FollowerDetailItemRepoViewController customizations
    private func configure() {
        itemViewOne.set(itemType: .repos, withCount: user.publicRepos)
        itemViewTwo.set(itemType: .gists, withCount: user.publicGists)
        
        callToActionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
