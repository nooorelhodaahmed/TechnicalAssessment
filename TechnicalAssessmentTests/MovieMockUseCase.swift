//
//  MovieMockInteractor.swift
//  TechnicalAssessmentTests
//
//  Created by norelhoda on 16/03/2024.
//

import Foundation
import XCTest
import RxSwift
import RxRelay

@testable import TechnicalAssessment

class MovieMockUseCase: MovieUseCaseType {
   
    let recentMovieListSubject = BehaviorRelay<[ResultsEntity]>(value: [])
    let disboseBag = DisposeBag()
    func fetchMovies(endPiont: String) -> PublishSubject<[ResultsEntity]?> {
        let model = mockResponse()
        return model
    }
    
    //MARK: - sut
    
    private func  mockResponse() -> PublishSubject<[ResultsEntity]?> {
        var mockArray = [ResultsEntity]()
        let mockSubject = PublishSubject<[ResultsEntity]?>()
        let firstItem = ResultsEntity(id: 763215,
                                      poster_path: "/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg",
                                      release_date: "2024-03-08",
                                      title: "Damsel")
        let secondItem = ResultsEntity(id: 763245,
                                       poster_path: "/sMp34cNKjIb18UBOCoAv4DpCxwY.jpg",
                                       release_date: "2024-03-08",
                                       title: "Damsel")
        mockArray.append(firstItem)
        mockArray.append(secondItem)
        mockSubject.onNext(mockArray)
        recentMovieListSubject.accept(mockArray)
        return mockSubject
    }
}

