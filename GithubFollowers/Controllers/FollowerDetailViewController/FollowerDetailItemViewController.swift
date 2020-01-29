//
//  FollowerItemViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/29/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerDetailItemViewController: UIViewController {
    
    //UI elements contained within VC
    let stackView = UIStackView()
    let itemViewOne = GFItemView()
    let itemViewTwo = GFItemView()
    let callToActionButton = GFButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureUIElements()
        configureUILayout()
    }
    
    
    //MARK: FollowerDetailItemViewController customizations
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func configureUIElements() {
        //add views to stackview
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }
    
    
    private func configureUILayout() {
        view.addSubview(stackView)
        view.addSubview(callToActionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
