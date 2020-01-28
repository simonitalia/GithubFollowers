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
    
    var followerLogin: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        configureUILayout()
        
        let username = followerLogin!
        NetworkManager.shared.getUser(for: username) { [weak self ] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                
                DispatchQueue.main.async {
                    let vc = FollowerDetailHeaderViewController(user: user)
                    self.add(childViewController: vc, to: self.headerView)
                }
//                print(user)
            
            case .failure(let error):
                self.presentGFAlertViewController(title: "Error Fetching User!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureUILayout() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    //function to add childrenVCs to this VC
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
