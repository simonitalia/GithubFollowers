//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/25/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    //UI Elements contained within UIView
    let placeholderImage = UIImage(named: "avatar-placeholder")

    //MARK: - UIImageView object initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
   }
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - GFUIImageView customizations
    private func configure() {
        layer.cornerRadius = 10 //applies to imageView radius, not image itself
        clipsToBounds = true //clip the image itself to the bounds of the view
        image = placeholderImage //in cases of null avatars, set placeholder image
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func fireGetImage(from urlString: String) {
        NetworkManager.shared.getImage(from: urlString) { [weak self] (image) in
            guard let self = self else { return }
            
            //set image
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
