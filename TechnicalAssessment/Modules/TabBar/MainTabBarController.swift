//
//  MainTabBarController.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 16/03/2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let main = MainCoordinator(navigationController: UINavigationController())
    let popular = PopularCoordinator(navigationController: UINavigationController())
    let upComing = UpComingCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        main.start()
        popular.start()
        upComing.start()
        
        viewControllers = [main.navigationController,popular.navigationController,upComing.navigationController]
        tabBar.items?[0].title = "Recent Movies"
        tabBar.items?[1].title = "popular Movies"
        tabBar.items?[2].title =  "Up Coming Movies"
    }
}
