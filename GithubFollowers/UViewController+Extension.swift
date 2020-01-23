//
//  UViewController+Extension.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertViewController(title: String, message: String, buttonTitle: String) {
        
        //present on main thread
        DispatchQueue.main.async { [unowned self] in
            let vc = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            vc.modalPresentationStyle = .overFullScreen
                //take over full screen esp. in iOS 13's new card style ui
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
}

