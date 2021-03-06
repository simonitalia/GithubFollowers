//
//  FollowersViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/23/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

protocol FollowersViewControllerDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersViewController: UIViewController {
    
    enum Section { //enums by default conform to Hashable protocol
       case main
    }
    
    //VC Properties
    var username: String!
    var followers = [Follower]()
    var hasMoreFollowers = true
        //track if user has more followers left to fetch (after fetchuing in icrementts of 100
    
    var filteredFollowers = [Follower]() //for storing followers that match search text criteria
    var isSearching = false
    
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
        //note, both objects (in this case Secton + Follower), must conform to Hashable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        createSearchController()
        createCollectionView()
        fireGetFollowers(for: username, from: NetworkCallParameter.page)
        configureCollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func createSearchController() {
        let sc = UISearchController()
        
        sc.searchResultsUpdater = self
        sc.searchBar.delegate = self
        
        sc.searchBar.placeholder = "search by username"
        sc.obscuresBackgroundDuringPresentation = false //set to true to dim view when searching, but this affects functionality which needs to be handled
        
        //embed the search controller inside navigation bar
        navigationItem.searchController = sc
    }
    
    
    func fireGetFollowers(for username: String, from page: Int) {
        
        //first check if user has more followers to fetch
        guard hasMoreFollowers == true else { return }
        
        //start network call
        showLoadingSpinner()
        
        NetworkManager.shared.getFollowers(for: username, from: page) { [weak self] (result) in
            
            guard let self = self else { return }
            
            self.hideLoadingSpinner()
            
            switch result {
            case .success(let deltaFollowers):
                
                //check if user has more followers to fetch and update flag if not
                if deltaFollowers.count < NetworkCallParameter.numberOfItems {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: deltaFollowers)
                
                //check for zero followers
                if self.followers.isEmpty {
                    let text = "User has 0 followers! 🙁\nMake their day and go follow them."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(withLabelText: text, in: self.view)
                    }
                    
                    return
                }
                
                self.updateCollectionViewSnapshotData(with: self.followers)
                print("Followers returned count: \(deltaFollowers.count)\n")
                //                print(followers)
                
            case .failure(let error):
                self.presentGFAlertViewController(title: "Error Fetching Data!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    func createCollectionView() {
        //create flow layout object
        let layout = UICollectionViewFlowLayout().createCollectionViewFlowLayout(view: view)
        
        //create collectionView (with layout obejct)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        
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
    
    
    //call this method after data is returned from the remote server
    func updateCollectionViewSnapshotData(with followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        //should be ok to update dataSource from background, but results in warnings if not wrapped in .main.async
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingSpinner()
        
        NetworkManager.shared.getUser(for: username) { [weak self ](result) in
            guard let self = self else { return }
            
            self.hideLoadingSpinner()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                //make save to favorites call
                DataPersistenceManager.updateFavorites(with: favorite, action: .add) { [weak self] (error) in
                    guard let self = self else { return }
                    
                    //display success alert
                    guard let error = error else {
                        self.presentGFAlertViewController(title: "Success!", message: "\(user.login) added to Favorites. 🎉" , buttonTitle: "OK")
                        return
                    }
                    
                    //display error alert
                    self.presentGFAlertViewController(title: "Oops!", message: error.rawValue, buttonTitle: "OK")
                }
             
            //display error alert
            case .failure(let error):
                self.presentGFAlertViewController(title: "Oops!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


//MARK: - UICollectionViewDelegate extension
extension FollowersViewController: UICollectionViewDelegate {
    
    //configure content parameters using scrollViewDelegete (nb: UICollectionView is a sublclass of UIScrollView)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //first check if user has more followers to fetch
        guard hasMoreFollowers == true else { return }
        
        let contentOffsetY = scrollView.contentOffset.y //how far user has scrolled along y axis
        let contentHeight = scrollView.contentSize.height //entire height of scrollView
        let frameHeight = scrollView.frame.size.height //screen size height
        
        //print statementes for seeing actual values (based on iphone size run of)
//        print("contentOffsetY: \(contentOffsetY)")
//        print("contentHeight: \(contentHeight)")
//        print("frameHeight: \(frameHeight)")
        
        //trigger get next 100 followers from page n
        if contentOffsetY > contentHeight - frameHeight {
//            page += 1 //increment page number
            NetworkCallParameter.page += 1
//            fireGetFollowers(for: username, from: page)
            fireGetFollowers(for: username, from: NetworkCallParameter.page)
        }
    }
}

//MARK: - UISearchResultsUpdating, UISearchBarDelegate extension
extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = FollowerDetailViewController()
        destinationVC.username = follower.login
        destinationVC.delegate = self
        let nc = UINavigationController(rootViewController: destinationVC)
        present(nc, animated: true)
        
    }
    
    
    //filter UICollectionView data with entered searchBar text
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        
        //fill array of filteredFollowers, matching searchText
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(searchText.lowercased())
        }
        
        updateCollectionViewSnapshotData(with: filteredFollowers)
    }
    
    //reset UICollectionView data to full data set on searchBar cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateCollectionViewSnapshotData(with: followers)
    }
}


//MARK: - FollowersViewController extension
extension FollowersViewController {
    func resetFollowersViewControllerPropertiesToDefaults() {
        NetworkCallParameter.page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        hasMoreFollowers = true
        isSearching = false
    }
}


//MARK: - FollowersViewControllerDelegate extension
extension FollowersViewController: FollowersViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        
        //reset VC and trigger fetch of follwers for user
        self.username = username
        title = username
        collectionView.setContentOffset(.zero, animated: true) //scroll back to top
        resetFollowersViewControllerPropertiesToDefaults()
        
        fireGetFollowers(for: username, from: NetworkCallParameter.page)
    }
}
