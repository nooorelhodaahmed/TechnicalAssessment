//
//  MovieConvertorInteractor.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation
import RxSwift

class MovieInteractor: MovieInteractorProtocol {
    
    func fetchMovies(endPiont:String) -> Observable<RecentMoviesModel> {
        return APIClient.fetchRecentMovies(endPiont: endPiont)
    }
    
    func fetchMovieDetails(id: Int) -> Observable<MovieDetailsModel> {
        return APIClient.fechMovieDetails(id: id)
    }
}

protocol MovieInteractorProtocol {
    func fetchMovies(endPiont:String) -> Observable<RecentMoviesModel>
    func fetchMovieDetails(id:Int) -> Observable<MovieDetailsModel>
}

extension MovieInteractorProtocol {
    func fetchMovieDetails(id:Int) -> Observable<MovieDetailsModel> {
        return  APIClient.fechMovieDetails(id: id)
    }
}
