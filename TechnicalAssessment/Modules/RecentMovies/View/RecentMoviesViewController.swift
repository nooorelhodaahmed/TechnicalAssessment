//
//  RecentMoviesViewController.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import UIKit
import RxSwift
import RxCocoa


class RecentMoviesViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel = MovieViewModel()
    private let identifier = "MoviesListTableViewCell"
    var disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpViewModel()
    }
    
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
        viewModel.fetchRecentMovies(endPiont: MovieTypes.recent.rawValue)
        bindTabelView()
        handleActivityIndicator()
        handleErrorMessage()
    }
    
    func bindTabelView() {
        viewModel.recentMovieListSubject.observe(on: MainScheduler.instance).bind(to:tableView.rx.items(cellIdentifier:identifier,cellType: MoviesListTableViewCell.self)) { (row,item,cell) in
            cell.movieNameLabel.text = item.title
            let url = baseUrl.dropLast() + (item.poster_path ?? "") + " " + apiKey
            cell.movieImageView.downloaded(from: url )
            cell.releaseDateLabel.text = item.release_date
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
