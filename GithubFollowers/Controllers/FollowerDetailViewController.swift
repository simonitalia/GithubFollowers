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
        print(follower.login)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true, completion: nil)
    }

}
