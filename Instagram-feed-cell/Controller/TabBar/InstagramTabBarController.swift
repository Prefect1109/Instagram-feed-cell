//
//  InstagramTabBarController.swift
//  Instagram-feed-cell
//
//  Created by Богдан Ткачук on 25.06.2020.
//  Copyright © 2020 Bohdan Tkachuk. All rights reserved.
//

import UIKit

class InstagramTabBarController: UITabBarController {
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        let homeNavController = templateNavController(for: HomeViewController(collectionViewLayout: UICollectionViewFlowLayout()), selectedImage: #imageLiteral(resourceName: "house.fill"), unselectedImage: #imageLiteral(resourceName: "house"))
        let searchNavController = templateNavController(for: SearchViewController(), selectedImage: #imageLiteral(resourceName: "search.fill"), unselectedImage: #imageLiteral(resourceName: "search"))
        let addContentNavController = templateNavController(for: AddContentViewController(), selectedImage: #imageLiteral(resourceName: "plus"), unselectedImage: #imageLiteral(resourceName: "plus"))
        let activityNavController = templateNavController(for: ActivityViewController(), selectedImage: #imageLiteral(resourceName: "like.fill"), unselectedImage: #imageLiteral(resourceName: "like"))
        let profileNavController = templateNavController(for: ProfileViewController(), selectedImage: #imageLiteral(resourceName: "user.fill"), unselectedImage: #imageLiteral(resourceName: "user"))
        
        tabBar.tintColor = .black
        
        viewControllers = [
            homeNavController,
            searchNavController,
            addContentNavController,
            activityNavController,
            profileNavController
        ]
        
        // Tab bar button insets
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
        }
    }
    
    private func templateNavController(for viewController: UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
