//
//  ViewController.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //VC Properties
    let tableView = UITableView()
    var favorites = [Follower]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fireGetFavorites()
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
    }
    
    
    private func fireGetFavorites() {
        DataPersistenceManager.getSavedFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(withLabelText: "You have 0 Favorites.\nAdd Favorites from the Followers List screen.", in: self.view)
                    
                } else {
//                print("Get Favorites successful.\nSaved Favorites: \(favorites.count)\nFavorites contents\(favorites)\n")
                    DispatchQueue.main.async {
                        self.favorites = favorites
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                self.presentGFAlertViewController(title: "Oops!", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}


//MARK: UITableViewDelegate extension
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowersViewController()
        destinationVC.username = favorite.login
        destinationVC.title = favorite.login
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        //remove favorite from table row and delete favorite from local favorite array
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        
        //remove favorite from saved favorites array in user defaults
        DataPersistenceManager.updateFavorites(with: favorite, action: .remove) { [weak self] (error) in
            guard let self = self else { return }
            
            guard let error = error else { return }
            self.presentGFAlertViewController(title: "Oops!", message: error.rawValue, buttonTitle: "OK")
        }
    }
}


//MARK: UITableViewDataSource extension
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier) as! FavoriteTableViewCell
        let favorite = favorites[indexPath.row]
        cell.setAvatarImageView(from: favorite.avatarUrl)
        cell.setUsernameLabel(text: favorite.login)
        return cell
    }
}

