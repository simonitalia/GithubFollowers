//
//  FavoriteTableViewCell.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/30/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FavoriteTableViewCell"
        //declared as static so it's accessible from the VC handling its presentation
    
    //UIElements contained within Cell
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 26)

    
    //MARK: UITableViewCell object initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAvatarImageView()
        configureUsernameLabel()
        configure()
    }
    
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: FavoriteTableViewCell customizations
    private func configure() {
        accessoryType = .disclosureIndicator
    }
    
    
    //method called when configuring the cell data in the UITableView in FavoritesVC
    func setUsernameLabel(text: String) {
        usernameLabel.text = text
    }
    
    
    func setAvatarImageView(from urlString: String) {
        avatarImageView.fireGetImage(from: urlString)
    }
    
    
    private func configureAvatarImageView() {
        addSubview(avatarImageView)
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    private func configureUsernameLabel() {
        addSubview(usernameLabel)
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
