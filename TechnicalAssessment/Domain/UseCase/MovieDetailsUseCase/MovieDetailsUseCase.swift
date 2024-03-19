//
//  MovieDetailsUseCase.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift

class MovieDetailsUseCase: MovieDetailsUseCaseType {
    
    let repo: MovieDetailsContract
    let disposeBag = DisposeBag()
   
    init(repo: MovieDetailsContract = MovieRepo()) {
        self.repo = repo
    }
    
    func fetchMovieDetails(id: Int) -> PublishSubject<MovieDetailsEntity?> {
        let modelSubject = PublishSubject<MovieDetailsEntity?>()
        let response = self.repo.fetchMovieDetails(id: id)

             response.subscribe { [weak self] responseDto in
                 modelSubject.onNext(self?.mapMovieDetails(from: responseDto))
             } onError: { error in
                 modelSubject.onError(error)
             } onCompleted: {
                 modelSubject.onCompleted()
             }.disposed(by: disposeBag)
          return modelSubject
        }
}
