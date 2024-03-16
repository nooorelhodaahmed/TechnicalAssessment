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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start () {
        let vc = RecentMoviesViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func navigateToMovieDetails(movieId:Int){
        let vc = MovieDetailsViewController.instantiate()
        vc.coordinator = self
        vc.movieId = movieId
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
