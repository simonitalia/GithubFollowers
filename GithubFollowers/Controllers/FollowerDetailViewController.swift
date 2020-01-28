//
//  FollowerDetailViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/28/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowerDetailViewController: UIViewController {
    
    var follower: Follower!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton

        
        let username = follower.login
        NetworkManager.shared.getUser(for: username) { [weak self ] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            
            case .failure(let error):
                self.presentGFAlertViewController(title: "Error Fetching User!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
