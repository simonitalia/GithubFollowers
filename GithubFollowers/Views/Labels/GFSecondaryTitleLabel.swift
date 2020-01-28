//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/28/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    //MARK: - UILabel object initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - GFSecondaryTitleLabel customizations
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90 //min shrinkage (10% max)
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
