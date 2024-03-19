//
//  MovieViewModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation
import RxSwift
import RxRelay

enum MovieTypes: String {
    case recent = "now_playing"
    case popular = "popular"
    case upComing = "upcoming"
}

class MovieViewModel {
    
    let disposebag = DisposeBag()
    let useCase: MovieUseCaseType
    var recentMovieListSubject = BehaviorRelay<[ResultsEntity]>(value: [])
    var errorMessageSubject = PublishSubject<String>()
    var isLoadingSubject = BehaviorRelay<Bool>(value: true)
    
    init(useCase: MovieUseCaseType = MovieUseCase()) {
        self.useCase = useCase
    }
    
    func fetchMovies(endPiont:String) {
        isLoadingSubject.accept(true)
        useCase.fetchMovies(endPiont: endPiont).subscribe(onNext:  { [weak self] response in
            if response == nil {
                self?.errorMessageSubject.onNext("something went wrong")
                self?.isLoadingSubject.accept(false)
            }
            else {
                self?.recentMovieListSubject.accept(response ?? [])
                self?.isLoadingSubject.accept(false)
            }
           
        }, onError: { [weak self] error in
            self?.isLoadingSubject.accept(false)
            self?.errorMessageSubject.onNext(error.localizedDescription)
        }).disposed(by: disposebag)
    }
}
