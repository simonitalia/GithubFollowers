//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section { //enums by default conform to Hashable protocol
        case main
    }
    
    //UI Elements contained within VC
    var username: String!
    var followers = [Follower]()
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
        //note, both objects (in this case Secton + Follower), must conform to Hashable

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createCollectionView()
        fireGetFollowers()
        configureCollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func fireGetFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateCollectionViewDataWithSnapshot()
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
        //create flow layout object
        let layout = UICollectionViewFlowLayout().createCollectionViewFlowLayout(view: view)
        
        //create collectionView (with layout obejct)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        //configure collectionView
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier) //registers our custom cell subclass
    }
    
    func configureCollectionViewCell() {
        
        //set dataSource for cells / items
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier, for: indexPath) as! FollowerCollectionViewCell
            
            //set cell text and image
            cell.setUsernameLabel(text: follower.login)
            cell.setAvatarImageView(from: follower.avatarUrl)
            return cell
        })
    }
    
    func updateCollectionViewDataWithSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        //should be ok to update dataSource from background, but results in warnings if not wrapped in .main.async
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}
