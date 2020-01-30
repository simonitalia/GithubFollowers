//
//  GFZeroFollowersStateView.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/27/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {

    //UI elements contained within UIView
    let label = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let imageView = UIImageView()
    
    //MARK: - UIView object initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        configureImageView()
    }
    
     //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - GFZeroFollowersStateView customizations
    init(labelText: String) {
        super.init(frame: .zero)
        label.text = labelText
        configureLabel()
        configureImageView()
    }
        
    private func configureLabel() {
        addSubview(label)
        label.numberOfLines = 3
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            label.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.image = UIImage(named: "empty-state-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40),
        ])
    }
}
