//
//  MovieDetailsViewController.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailsViewController: UIViewController,Storyboarded {

    //MARK: - Proporties
    var movieId : Int?
    let viewModel = MovieViewModel()
    weak var coordinator : MainCoordinator?
    weak var popularCoordinator : PopularCoordinator?
    weak var upComingCoordinator : UpComingCoordinator?
    let disposeBag = DisposeBag()
    
    //MARK: - Outlets
    @IBOutlet weak var overViewLabel:UILabel!
    @IBOutlet weak var runTimeLabel:UILabel!
    @IBOutlet weak var genresLabel:UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterImage :UIImageView!
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        handleActivityIndicator()
        handleErrorMessage()
    }
}

//MARK: - BindViewModel

extension MovieDetailsViewController {
    
    func setUpViewModel(){
        self.viewModel.fetchMovieDetails(id: movieId ?? 0)
        self.viewModel.movieDetailsSubject
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self]  movie in
            let url = imageBaseUrl + (movie.poster_path ?? "")
            self?.posterImage.downloaded(from: url)
            self?.overViewLabel.text = movie.overview
            if let runtime = movie.runtime {
                self?.runTimeLabel.text = ("\(runtime)")
            }
            self?.genresLabel.text = self?.setUpGeners(genres: movie.genres ?? [])
            
        }.disposed(by: disposeBag)
    }
    
    func setUpGeners(genres:[Genres]) -> String{
        var genersText = ""
        for i in 0..<genres.count {
            genersText = genersText + (genres[i].name ?? "") + " "
        }
        return genersText
    }
    
    func handleErrorMessage() {
        viewModel.errorMessageSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let self = self else { return }
            self.show(messageAlert: "Error", message: error)
        }).disposed(by: disposeBag)
    }
    
    func handleActivityIndicator() {
        viewModel.isLoadingSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else { return }
            self.activityIndicator.isHidden = !isLoading
            isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }).disposed(by: disposeBag)
    }
}
