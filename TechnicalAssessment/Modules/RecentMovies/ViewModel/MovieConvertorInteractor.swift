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
    
//    func fetchCharchterDetails(id:String) -> Observable<CharchterDetailsModel> {
//        return APIClient.fechCharchterDetails(id: id)
//    }
}

protocol MovieInteractorProtocol {
    func fetchMovies(endPiont:String) -> Observable<RecentMoviesModel>
   // func fetchCharchterDetails(id:String) -> Observable<CharchterDetailsModel>
}

//extension MovieInteractorProtocol {
//    func fetchCharchterDetails(id:String) -> Observable<CharchterDetailsModel> {
//        return  APIClient.fechCharchterDetails(id: id)
//    }
//}
