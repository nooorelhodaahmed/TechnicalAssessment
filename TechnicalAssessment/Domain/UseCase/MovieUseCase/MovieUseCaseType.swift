//
//  MovieUseCaseType.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

protocol MovieUseCaseType {
    func fetchMovies(endPiont:String) -> PublishSubject<[ResultsEntity]?>
}
