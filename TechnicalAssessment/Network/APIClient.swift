//
//  APIClient.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation
import RxSwift

class APIClient {
    
    static func fetchRecentMovies(endPiont:String) -> Observable<RecentMoviesModel> {
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: URL(string: baseUrl + endPiont + apiKey)!) { data, response, error in
                // data is empty
                guard let data = data else {
                    observable.onError(NSError(domain: "", code: -1, userInfo: nil))
                    observable.onCompleted()
                    return
                }
                do {
                    
                     let movie = try JSONDecoder().decode(RecentMoviesModel.self, from: data)

                    observable.onNext(movie)
                } catch {
                    do {
                        //error i can decode
                        let errorMessage = try JSONDecoder().decode(ErrorModel.self, from: data)
                        observable.onError(errorMessage.error)
                    } catch {
                        //unexpected error
                        observable.onError(error)
                    }
                }
                observable.onCompleted()
            }
            
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    static func fechMovieDetails(id:Int) -> Observable<MovieDetailsModel> {
        return Observable.create { observable -> Disposable in
            let urlString = "\(baseUrl)\(id)\(apiKey)"
    
            let task = URLSession.shared.dataTask(with: URL(string:urlString)!){ data, response, error in
                // data is empty
                guard let data = data else {
                    observable.onError(NSError(domain: "", code: -1, userInfo: nil))
                    observable.onCompleted()
                    return
                }
                do {
                    let movieDetail = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
                    observable.onNext(movieDetail)
                } catch {
                    do {
                        //error i can decode
                        let errorMessage = try JSONDecoder().decode(ErrorModel.self, from: data)
                        observable.onError(errorMessage.error)
                    } catch {
                        //unexpected error
                        observable.onError(error)
                    }
                }
                observable.onCompleted()
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
