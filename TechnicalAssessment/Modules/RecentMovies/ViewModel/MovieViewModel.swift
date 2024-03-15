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
    case recent = "ow_playing"
    case popular = "popular"
    case topRated = "top_rated"
}

class MovieViewModel {
    
    let disposebag = DisposeBag()
    let interactor: MovieInteractorProtocol
    var recentMovieListSubject = BehaviorRelay<[Results]>(value: [])
    var errorMessageSubject = PublishSubject<String>()
    var isLoadingSubject = BehaviorRelay<Bool>(value: true)
    
    init(interacor: MovieInteractorProtocol = MovieInteractor()) {
        self.interactor = interacor
    }
    
    func fetchRecentMovies(endPiont:String){
        isLoadingSubject.accept(true)
        interactor.fetchMovies(endPiont: endPiont).subscribe(onNext:  { [weak self] response in
            self?.recentMovieListSubject.accept(response.results ?? [])
            self?.isLoadingSubject.accept(false)
        }, onError: { [weak self] error in
            self?.isLoadingSubject.accept(false)
            self?.errorMessageSubject.onNext(error.localizedDescription)
        }).disposed(by: disposebag)
    }
}
