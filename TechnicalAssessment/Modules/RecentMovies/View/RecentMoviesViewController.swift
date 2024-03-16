//
//  RecentMoviesViewController.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import UIKit
import RxSwift
import RxCocoa

class RecentMoviesViewController: UIViewController, Storyboarded {

    //MARK: - Outlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Proporties
    let viewModel = MovieViewModel()
    weak var coordinator : MainCoordinator?
    private let identifier = "MoviesListTableViewCell"
    var disposeBag = DisposeBag()
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
    }
    
    //MARK: - SetUpView
    func setUpView() {
        registerTableViewCell()
        tableView.delegate = self
    }

    func registerTableViewCell() {
        let nib = UINib.init(nibName: identifier, bundle: nibBundle)
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
}

//MARK: - Bind View Model
extension RecentMoviesViewController : UITableViewDelegate {
   
    func setUpViewModel() {
        viewModel.fetchMovies(endPiont: MovieTypes.recent.rawValue)
        bindTabelView()
        handleErrorMessage()
        handleActivityIndicator()
    }
    
    func bindTabelView() {
        viewModel.recentMovieListSubject.observe(on: MainScheduler.instance).bind(to:tableView.rx.items(cellIdentifier:identifier,cellType: MoviesListTableViewCell.self)) { (row,item,cell) in
            cell.configureCell(model:item)
        }.disposed(by: disposeBag)
        
        //coordinator 
        tableView.rx.modelSelected(Results.self).observe(on: MainScheduler.instance).subscribe(onNext:{ movie in
            self.coordinator?.navigateToMovieDetails(movieId: movie.id ?? 0)
        }).disposed(by: disposeBag)
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
