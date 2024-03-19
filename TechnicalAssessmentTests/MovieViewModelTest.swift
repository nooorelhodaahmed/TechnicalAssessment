//
//  MovieViewModelTset.swift
//  TechnicalAssessmentTests
//
//  Created by norelhoda on 16/03/2024.
//

import XCTest
import RxSwift

@testable import TechnicalAssessment

class MovieViewModelTest: XCTestCase {
    
    var sut: MovieViewModel!
    var disboseBag: DisposeBag!
    var useCase: MovieMockUseCase!
    
    override func setUp() {
        useCase = MovieMockUseCase()
        sut = MovieViewModel(useCase: useCase)
        disboseBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        disboseBag = nil
        useCase = nil
    }
    
    func test_movie_WhenRecentMovieIsFetched() {
        sut.fetchMovies(endPiont: "")
        var result = [ResultsEntity]()
        let expected  = expectation(description: "fetch movies")
        useCase.recentMovieListSubject.subscribe(onNext: { movies in
            result = movies
            expected.fulfill()
        }).disposed(by: disboseBag)
        wait(for: [expected], timeout: 2)
        XCTAssertNotNil(result)
        XCTAssertEqual(result[0].title,"Damsel")
    }
    
    func test_movie_WhenRecentMoviefauiler() {
        sut.fetchMovies(endPiont: "")
        let result = [ResultsEntity]()
        let expected  = expectation(description: "fetch fauiler")
        expected.fulfill()
        wait(for: [expected], timeout: 2)
        XCTAssertEqual(result.count, 0)
    }
}
