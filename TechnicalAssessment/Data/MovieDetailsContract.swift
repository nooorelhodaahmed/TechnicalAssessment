//
//  MovieDetailsContract.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

protocol MovieDetailsContract {
    func fetchMovieDetails(id:Int) -> PublishSubject<MovieDetailsDTO>
}
