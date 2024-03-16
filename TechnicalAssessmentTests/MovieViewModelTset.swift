//
//  MovieViewModelTset.swift
//  TechnicalAssessmentTests
//
//  Created by norelhoda on 16/03/2024.
//

import XCTest
import RxSwift

@testable import TechnicalAssessment

class MovieViewModelTset: XCTestCase {
    
    var sut: MovieViewModel!
    var disboseBag: DisposeBag!
    
    override func setUp() {
        sut = MovieViewModel(interacor: MovieMockInteractor())
        disboseBag = DisposeBag()
    }
    
    override func tearDown(){
        sut = nil
        disboseBag = nil
    }
    
    func test_movieViewModelWhenRecentMovieIsFetched(){
        sut.fetchMovies(endPiont: MovieTypes.recent.rawValue)
        var result = [Results]()
        let expected  = expectation(description: "currency converting")
        sut.recentMovieListSubject.subscribe(onNext: { movies in
            result = movies
            expected.fulfill()
        }).disposed(by: disboseBag)
        wait(for: [expected], timeout: 2)
        XCTAssertNotNil(result)
        XCTAssertEqual(result[0].title , "Damsel")
    }
}
