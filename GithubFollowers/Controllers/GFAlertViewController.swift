//
//  UIAlertViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class GFAlertViewController: UIViewController {
    
    //UI elements / objects and properties
    let alertContainerView = GFAlertContainerView()
    
    let alertTitleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    var alertTitleText: String!
    
    let alertMessageBodyLabel = GFBodyLabel(textAlignment: .center)
    var alertMessageBodyText: String!
    
    let alertCallToActionButton = GFButton(backgroundColor: .systemPink, title: "OK")
    var alertButtonTitleText: String!
    
    //this is required for storyboard based apps
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: GFAlertViewController customizations
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitleText = title
        self.alertMessageBodyText = message
        self.alertButtonTitleText = buttonTitle
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75) //75% opaque
        configureAlertContainerView()
        configureAlertTitleLabel()
        configureAlertCallToActionButton()
        configureAlertMessageBodyLabel()
    }
    
    func configureAlertContainerView() {
        view.addSubview(alertContainerView)
        
        //add layout constraints
        NSLayoutConstraint.activate([
            alertContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertContainerView.widthAnchor.constraint(equalToConstant: 280),
            alertContainerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    //alert title label
    func configureAlertTitleLabel() {
        alertContainerView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitleText ?? "Action Required"
        
        //add layout constraints
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: alertContainerView.topAnchor, constant: padding),
            alertTitleLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: padding),
            alertTitleLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -padding),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    //alert message label
    func configureAlertMessageBodyLabel() {
        alertContainerView.addSubview(alertMessageBodyLabel)
        alertMessageBodyLabel.text = alertMessageBodyText ?? "Well that didn't work. Please try again!"
        alertMessageBodyLabel.numberOfLines = 4
        
        //add layout constraints
        let padding: CGFloat = 20
        NSLayoutConstraint.activate([
            alertMessageBodyLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 8),
            alertMessageBodyLabel.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: padding),
            alertMessageBodyLabel.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -padding),
            alertMessageBodyLabel.bottomAnchor.constraint(equalTo: alertCallToActionButton.topAnchor, constant: -12)
        ])
    }
    
    //alert call to action
    func configureAlertCallToActionButton() {
        alertContainerView.addSubview(alertCallToActionButton)
        alertCallToActionButton.setTitle(alertButtonTitleText ?? "OK", for: .normal)
        alertCallToActionButton.addTarget(self, action: #selector(dismissAlertViewController), for: .touchUpInside)
        
        //add layout constraints
        let padding: CGFloat  = 20
        NSLayoutConstraint.activate([
            alertCallToActionButton.bottomAnchor.constraint(equalTo: alertContainerView.bottomAnchor, constant: -padding),
            alertCallToActionButton.leadingAnchor.constraint(equalTo: alertContainerView.leadingAnchor, constant: padding),
            alertCallToActionButton.trailingAnchor.constraint(equalTo: alertContainerView.trailingAnchor, constant: -padding),
            alertCallToActionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    //dismiss alertVC
    @objc func dismissAlertViewController() {
        dismiss(animated: true, completion: nil)
        
    }
    
   
    
    
    
    

}
