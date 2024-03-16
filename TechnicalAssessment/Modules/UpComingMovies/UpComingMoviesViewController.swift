//
//  UpComingMoviesViewController.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import UIKit
import RxSwift
import RxCocoa

class UpComingMoviesViewController: UIViewController,Storyboarded {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Proporties
    weak var coordinator : MainCoordinator?
    let viewModel = MovieViewModel()
    private let identifier = "MoviesListTableViewCell"
    var disposeBag = DisposeBag()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
    }
    
    //MARK: - SetupView
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
extension UpComingMoviesViewController : UITableViewDelegate {
    
    func setUpViewModel() {
        viewModel.fetchMovies(endPiont: MovieTypes.upComing.rawValue)
        bindTabelView()
        handleActivityIndicator()
        handleErrorMessage()
    }
    
    func bindTabelView() {
        viewModel.recentMovieListSubject.observe(on: MainScheduler.instance).bind(to:tableView.rx.items(cellIdentifier:identifier,cellType: MoviesListTableViewCell.self)) { (row,item,cell) in
            cell.configureCell(model:item)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Results.self).observe(on: MainScheduler.instance).subscribe(onNext:{ movie in
            let vc = MovieDetailsViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.movieId = movie.id
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    func handleErrorMessage() {
        viewModel.errorMessageSubject.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let self = self else { return }
            self.show(messageAlert: "Error", message: "somethig went wrong")
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
