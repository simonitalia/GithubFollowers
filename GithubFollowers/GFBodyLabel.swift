//
//  GFBodyLabel.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

     //MARK: UILabel object initializers
    override init(frame: CGRect) {
           super.init(frame: frame)
//           configure()
       }
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: GFBodyLabel customizations
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75 //min shrinkage (25% max)
        lineBreakMode = .byWordWrapping
    }
}
