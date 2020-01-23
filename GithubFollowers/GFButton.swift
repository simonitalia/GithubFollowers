//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    //setup base UIButton object with its initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //add GFButton customization ontop of underlying UIButton
//        configure()
    }
    
    //MARK: UIButtom Required init
    //used for initialization in storyboard implementations, not required in this (non-stpryboard) app, but init must be present in UIButton sublass
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: GFButton customizations
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero) //set to .zero since this will be set via auto layout
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) //bold
        translatesAutoresizingMaskIntoConstraints = false
    }
}
