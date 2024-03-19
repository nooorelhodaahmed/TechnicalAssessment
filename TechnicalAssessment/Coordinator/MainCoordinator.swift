//
//  MainCoordinator.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import UIKit

class MainCoordinator: Coordinator {
   
    var childCoordinators = [Coordinator]()
    var navigationController : UINavigationController
    var rootViewCintrolelr = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start () {
        let vc = RecentMoviesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToMovieDetails(movieId:Int) {
        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        vc.coordinator = self
        vc.movieId = movieId
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}


