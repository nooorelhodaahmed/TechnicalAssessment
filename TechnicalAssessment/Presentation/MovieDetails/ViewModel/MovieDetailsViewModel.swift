//
//  MovieDetailsViewModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation
import RxSwift
import RxRelay

class MovieDetailsViewModel {
    
    let disposebag = DisposeBag()
    let useCase: MovieDetailsUseCaseType
    var movieDetailsSubject = PublishRelay<MovieDetailsEntity>()
    var errorMessageSubject = PublishSubject<String>()
    var isLoadingSubject = BehaviorRelay<Bool>(value: true)
    
    init(useCase: MovieDetailsUseCaseType = MovieDetailsUseCase()) {
        self.useCase = useCase
    }
    
    func fetchMovieDetails(id:Int) {
        isLoadingSubject.accept(true)
        useCase.fetchMovieDetails(id: id).subscribe(onNext:{ [weak self] response in
            guard let response = response else{return}
                self?.movieDetailsSubject.accept(response)
                self?.isLoadingSubject.accept(false)
            
        },onError: { [weak self] error in
            self?.isLoadingSubject.accept(false)
            self?.errorMessageSubject.onNext(error.localizedDescription)
        }).disposed(by: disposebag)
    }
}
