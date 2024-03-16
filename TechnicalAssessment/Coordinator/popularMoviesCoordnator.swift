//
//  popularMoviesCoordnator.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 16/03/2024.
//

import Foundation
import UIKit

class PopularCoordinator: Coordinator {
   
    var childCoordinators = [Coordinator]()
    var navigationController : UINavigationController
    var rootViewCintrolelr = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start () {
        let vc = PopularMoviesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func navigateToMovieDetails(movieId:Int){

        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
        vc.popularCoordinator = self
        vc.movieId = movieId
        vc.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(vc, animated: true)
    }
}
