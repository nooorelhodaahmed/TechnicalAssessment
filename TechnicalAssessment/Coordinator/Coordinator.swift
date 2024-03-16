//
//  Coordinator.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import UIKit

protocol Coordinator {
   
    var childCoordinators : [Coordinator] {get set}
    var navigationController : UINavigationController {get set}
    func start()
}
