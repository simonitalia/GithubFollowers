//
//  GFTextField.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //required init used for storyboard initialization
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Custom GFTextField configuration
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
            //use UISemantics github app to see how system colors look in light and dark modes
        
        textColor = .label //whtie text on black background, black text on white background
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true //shrink to fit text
        minimumFontSize = 12 //don't shrink text beyond 12
        returnKeyType = .go //sets text of return key shown in kb
        placeholder = "Enter username" 
    }
    
    
    
    

}
