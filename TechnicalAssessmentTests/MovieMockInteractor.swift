//
//  MovieMockInteractor.swift
//  TechnicalAssessmentTests
//
//  Created by norelhoda on 16/03/2024.
//

import Foundation
import XCTest
import RxSwift

@testable import TechnicalAssessment

class MovieMockInteractor: MovieInteractorProtocol {
   
    func fetchMovies(endPiont: String) -> Observable<RecentMoviesModel> {
        let model = try! JSONDecoder().decode(RecentMoviesModel.self, from: data)
        return .just(model)
    }
    
    //MARK: - sut

    private let data = """
    {
        "dates" : {
               "maximum" : "2024-03-20",
               "minimum": "2024-02-07"
              },
        "page" : 1,
        "results" : [
                  {
                 "id": 763215,
                 "poster_path": "/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg",
                 "release_date": "2024-03-08",
                 "title": "Damsel"
                 }
               ],
    "total_pages" : 187,
    "total_results" : 3728
    }
    """.data(using: .utf8)!
}

