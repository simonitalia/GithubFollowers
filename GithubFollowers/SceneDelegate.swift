//
//  SceneDelegate.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/22/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        //create tabBarVC
        let tabBarController = createTabBarController()
        
        //setup window
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController //set tabBarVC as root window vc
        window?.makeKeyAndVisible() //shows the vc
    }
    
    //setup SearchVC
    func createSearchNavigationController () -> UINavigationController {
        
        //create vc object
        let vc = SearchViewController()
        vc.title = "Search"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        //embed vc object inside nc object and return it
        return UINavigationController(rootViewController: vc)
    }
    
    //setup FavoritesVC
    func createFavoritesNavigationController () -> UINavigationController {
        
        //create vc object
        let vc = FavoritesViewController()
        vc.title = "Favorites"
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        //embed vc object inside nc object and return it
        return UINavigationController(rootViewController: vc)
    }
    
    func createTabBarController() -> UITabBarController {
        
        //create and configure TabBar
        let tabBarController = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        let searchVC = createSearchNavigationController()
        let favoritesVC = createFavoritesNavigationController()
        tabBarController.viewControllers = [searchVC, favoritesVC]
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

