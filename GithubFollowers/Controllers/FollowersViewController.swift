//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    //UI Elements contained within VC
    var username: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createCollectionView()
        fireGetFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func fireGetFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [unowned self] (result) in
            
            switch result {
            case .success(let followers):
                print("Followers.count: \(followers.count)\n")
//                print(followers)
                
            case .failure(let error):
                self.presentGFAlertViewController(title: "Error Fetching Data!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func createCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier)
            //register custom cell subclass
    }
    
    func createCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        
        //configure width of cells / columns based on 3 column layout
        let numberOfColumns: CGFloat = 3
        
        //set properies to calculate cell width
        let viewWidth = view.bounds.width //CGFloat value
        let edgeInsetsPadding: CGFloat = 12
        let minimumCellSpacing: CGFloat = 10 * 2
            //x2 to account for spacing between first / left most column and middle column, + the last / right most column and middle column (3 columns total)
        
        //calculate cell width
        let availableWidthForCell = viewWidth - (edgeInsetsPadding * 2) - minimumCellSpacing
            //edgeInsets *2 to allow for both left + right edges of screen
        
        //set cell width
        let cellWidth = availableWidthForCell / numberOfColumns
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: edgeInsetsPadding, left: edgeInsetsPadding, bottom: edgeInsetsPadding, right: edgeInsetsPadding)
        layout.sectionInset = layout.setEdgeInsets(to: edgeInsetsPadding)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return layout
    }
}
