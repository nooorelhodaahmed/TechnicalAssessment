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
    let interactor: MovieInteractorProtocol
    var recentMovieListSubject = BehaviorRelay<[Results]>(value: [])
    var movieDetailsSubject = PublishRelay<MovieDetailsModel>()
    var errorMessageSubject = PublishSubject<String>()
    var isLoadingSubject = BehaviorRelay<Bool>(value: true)
    
    init(interacor: MovieInteractorProtocol = MovieInteractor()) {
        self.interactor = interacor
    }
    
    func fetchMovies(endPiont:String) {
        isLoadingSubject.accept(true)
        interactor.fetchMovies(endPiont: endPiont).subscribe(onNext:  { [weak self] response in
            if response.results == nil {
              //  self?.isLoadingSubject.accept(false)
                self?.errorMessageSubject.onNext("something went wrong")
                self?.isLoadingSubject.accept(false)
            }
            else {
                self?.recentMovieListSubject.accept(response.results ?? [])
                self?.isLoadingSubject.accept(false)
            }
           
        }, onError: { [weak self] error in
            self?.isLoadingSubject.accept(false)
            self?.errorMessageSubject.onNext(error.localizedDescription)
        }).disposed(by: disposebag)
    }
    
    func fetchMovieDetails(id:Int) {
        isLoadingSubject.accept(true)
        interactor.fetchMovieDetails(id: id).subscribe(onNext:{ [weak self] response in
            self?.movieDetailsSubject.accept(response)
            self?.isLoadingSubject.accept(false)
        },onError: { [weak self] error in
            self?.isLoadingSubject.accept(false)
            self?.errorMessageSubject.onNext(error.localizedDescription)
        }).disposed(by: disposebag)
    }
}
