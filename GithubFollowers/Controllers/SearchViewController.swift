//
//  SearchViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    //UI Elements contained within VC
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameTextFieldEmpty: Bool {
        get {
            return usernameTextField.text!.isEmpty //returns true if field is empty, otherwise returns false
        }
            //note! get block and return keyword not actually required, just including for future reference
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: true)
            //ensure to hide the navBar when navigating back from anonther VC that shows the navBar
    }
    
    func createDismissKeyboardTapGesture() {
        
        //add a tap gesture recognizer to the entire view to trigger kb dismissal
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) //.endEditing = resign first responder
        view.addGestureRecognizer(tap)
    }
    
    //handle passping data to an dtriggering target VC on events
    @objc func pushToFollowersViewController() {
        
        //check usernameTextField is not empty
        guard !isUsernameTextFieldEmpty else {
            presentGFAlertViewController(title: "Username Empty!", message: "Please enter a GitHub username.", buttonTitle: "OK")
            return }
        
        let vc = FollowersViewController()
        vc.username = usernameTextField.text
        vc.title = usernameTextField.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
            //importantly adds the view to the viewcontroller for display
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        //set contsraints programmatically
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200), //imageView height
            logoImageView.widthAnchor.constraint(equalToConstant: 200) //imageView width

        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self //set to self to listen for textField updates
        
        //add layout constraints
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        
        //add layout constraints
        let padding: CGFloat = 50
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //submit data to and trigger display of target VC
        callToActionButton.addTarget(self, action: #selector(pushToFollowersViewController), for: .touchUpInside)
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    //submit data to and trigger display of target VC
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToFollowersViewController()
        return true
    }
    
}
