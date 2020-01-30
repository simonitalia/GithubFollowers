//
//  FollowerDetailItemFollowerViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/29/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerDetailItemFollowerViewController: FollowerDetailItemViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    //MARK: FollowerDetailItemFollowerViewController customizations
    private func configure() {
        itemViewOne.set(itemType: .followers, withCount: user.followers)
        itemViewTwo.set(itemType: .following, withCount: user.following)
        
        callToActionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func callToActionButtonTapped() {
        delegate.didTapDetailItemButton(with: .getFollowers, for: user)
    }
}
