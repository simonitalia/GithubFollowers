//
//  FollowerItemViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/29/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

//super class for FollowerDetailItemRepoViewController + FollowerDetailItemFollowerViewController
class FollowerDetailItemViewController: UIViewController {
    
    //UI elements contained within VC
    let stackView = UIStackView()
    let itemViewOne = GFItemView()
    let itemViewTwo = GFItemView()
    let callToActionButton = GFButton()
        //not using custom init, since properties will be applied by subclass VCs
    
    var user: User!
    weak var delegate: FollowerDetailViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        addUIElements()
        configureUIElements()
        configureCallToActionButtonTarget()
        configureUILayout()
    }
    
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: FollowerDetailItemViewController customizations
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func addUIElements() {
        view.addSubview(stackView)
        view.addSubview(callToActionButton)
    }
    
    
    private func configureUIElements() {
        //add views to stackview
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
    }
    
    
    private func configureCallToActionButtonTarget() {
        callToActionButton.addTarget(self, action: #selector(callToActionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func callToActionButtonTapped() {}
    
    
    private func configureUILayout() {
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
