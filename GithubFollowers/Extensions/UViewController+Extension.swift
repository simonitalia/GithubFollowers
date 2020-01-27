//
//  UViewController+Extension.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    
    //MARK: - alert
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
    
    //MARK: - activity indicator
    func showLoadingSpinner() {
        
        //configure containerView
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        //animate container view into view
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        //create and configure spinner
        let spinner = UIActivityIndicatorView(style: .large)
        containerView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        //place spinner in center of housing view (x and y axis)
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
             spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        spinner.startAnimating()
    }
    
    func hideLoadingSpinner() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
       }
    }
    
    func showEmptyStateView(withLabelText text: String, in parentView: UIView) {
        let emptyStateView = GFEmptyStateView(labelText: text)
        emptyStateView.frame = parentView.bounds
        parentView.addSubview(emptyStateView)
    }
}

