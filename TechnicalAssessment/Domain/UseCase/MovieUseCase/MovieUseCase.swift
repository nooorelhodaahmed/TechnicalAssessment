//
//  MovieUseCase.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

class MovieUseCase: MovieUseCaseType {
    
    let repo: MovieContract
    let disposeBag = DisposeBag()
   
    init(repo: MovieContract = MovieRepo()) {
        self.repo = repo
    }
    
    func fetchMovies(endPiont:String) -> PublishSubject<[ResultsEntity]?>  {
        let modelSubject = PublishSubject<[ResultsEntity]?>()
        let response = self.repo.fetchMovies(endPiont: endPiont)
        response.subscribe { [weak self] responseDto in
            modelSubject.onNext(self?.mapRecentMovie(from: responseDto))
        } onError: { error in
            modelSubject.onError(error)
        } onCompleted: {
            modelSubject.onCompleted()
        }.disposed(by: disposeBag)
        return modelSubject
    }
}
