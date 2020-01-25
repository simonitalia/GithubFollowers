//
//  FollowerCollectionViewCell.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/25/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FollowerCollectionViewCell"
        //declared as static so it's accessible from the VC handling its presentation
    
    //UIElements contained within Cell
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    //MARK: UIColletionViewCell object initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAvatarImageView()
        configureUsernameLabel()
    }
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        return usernameLabel.text = follower.login
    }
    
    
    //MARK: FollowerCollectionViewCell customizations
    private func configureAvatarImageView() {
        addSubview(avatarImageView)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
                //make width and height equal to ensure imageView is a square
        ])
    }

    private func configureUsernameLabel() {
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
                //sst to 20 to allow some headroom as text font size of label.text is set to 16
        ])
    }
    
}
