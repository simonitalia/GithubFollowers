//
//  GFTitleLabel.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {

    //MARK: - UILabel object initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - GFTitleLabel customizations
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9 //min shrinkage (10% max)
        lineBreakMode = .byTruncatingTail
    }

}
