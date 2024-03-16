//
//  Storyboarded.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate () -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate () -> Self {
        let id = String(String(describing: self))
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
