//
//  FollowerDetailViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/28/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerDetailViewController: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews = [UIView]()
    
    var followerLogin: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        addUIElements()
        configureUILayout()
        fireGetUser()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func addUIElements() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            view.addSubview(itemView)
        }
    }
    
    
    private func configureUILayout() {
        let padding: CGFloat = 20
        let itemViewHeight: CGFloat = 140
        
        for itemView in itemViews {
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func fireGetUser() {
        let username = followerLogin!
        NetworkManager.shared.getUser(for: username) { [weak self ] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async {
                    //set header
                    let headerVC = FollowerDetailHeaderViewController(user: user)
                    self.addChild(viewController: headerVC, to: self.headerView)
                    
                    //set itemView one
                    let itemViewOneVC = FollowerDetailItemRepoViewController(user: user)
                    self.addChild(viewController: itemViewOneVC, to: self.itemViewOne)
                    
                    //set itemViewTwo
                    let itemViewTwoVC = FollowerDetailItemFollowerViewController(user: user)
                    self.addChild(viewController: itemViewTwoVC, to: self.itemViewTwo)
                    
                    //set dateLabel
                    self.dateLabel.text = "GitHub Since: "+user.createdAt.convertToFormattedDate()
                }
//                print(user)
                
            case .failure(let error):
                self.presentGFAlertViewController(title: "Error Fetching User!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    //function to add childrenVCs to this VC
    private func addChild(viewController: UIViewController, to containerView: UIView) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.didMove(toParent: self)
    }
    
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
