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
        NetworkManager.shared.getFollowers(for: username, page: 1) { [unowned self] (result) in
            
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
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
//        layout.sectionInset = UIEdgeInsets(top: edgeInsetsPadding, left: edgeInsetsPadding, bottom: edgeInsetsPadding, right: edgeInsetsPadding)
        layout.sectionInset = layout.setEdgeInsets(to: edgeInsetsPadding)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return layout
    }
    
    func configureCollectionViewCell() {
        
        //set dataSource for cells / items
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: self.collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseIdentifier, for: indexPath) as! FollowerCollectionViewCell
            
            //set usernameLabel text
            cell.setUsernameLabel(text: follower.login)
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
