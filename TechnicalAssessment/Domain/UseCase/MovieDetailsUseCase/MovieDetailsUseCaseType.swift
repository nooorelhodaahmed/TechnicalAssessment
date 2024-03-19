//
//  MovieDetailsUseCaseType.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

protocol MovieDetailsUseCaseType {
    func fetchMovieDetails(id:Int) -> PublishSubject<MovieDetailsEntity?>
}
