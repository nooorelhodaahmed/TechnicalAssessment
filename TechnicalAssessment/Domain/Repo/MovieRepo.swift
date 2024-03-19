//
//  MovieRepo.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

class MovieRepo: MovieContract {
    
    func fetchMovies(endPiont:String) -> PublishSubject<RecentMoviesDTO> {
        return APIClient.fetchRecentMovies(endPiont: endPiont)
    }
}

extension MovieRepo: MovieDetailsContract {
    
    func fetchMovieDetails(id: Int) -> PublishSubject<MovieDetailsDTO> {
         return APIClient.fechMovieDetails(id: id)
     }
}
