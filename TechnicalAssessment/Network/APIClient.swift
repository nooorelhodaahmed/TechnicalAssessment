//
//  APIClient.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation
import RxSwift

class APIClient {
    
    static func fetchRecentMovies(endPiont:String) -> PublishSubject<RecentMoviesDTO> {
          let responseSubject = PublishSubject<RecentMoviesDTO>()
            let task = URLSession.shared.dataTask(with: URL(string: baseUrl + endPiont + apiKey)!) { data, response, error in
                // data is empty
                guard let data = data else {
                    responseSubject.onError(NSError(domain: "", code: -1, userInfo: nil))
                    responseSubject.onCompleted()
                    return
                }
                do {
                    
                     let movie = try JSONDecoder().decode(RecentMoviesDTO.self, from: data)

                    responseSubject.onNext(movie)
                } catch {
                    do {
                        //error i can decode
                        let errorMessage = try JSONDecoder().decode(ErrorModel.self, from: data)
                        responseSubject.onError(errorMessage.error)
                    } catch {
                        //unexpected error
                        responseSubject.onError(error)
                    }
                }
                responseSubject.onCompleted()
            }
            task.resume()
            return responseSubject
        }

    
    static func fechMovieDetails(id:Int) -> PublishSubject<MovieDetailsDTO> {
        let responseSubject = PublishSubject<MovieDetailsDTO>()
            let urlString = "\(baseUrl)\(id)\(apiKey)"
    
            let task = URLSession.shared.dataTask(with: URL(string:urlString)!){ data, response, error in
                // data is empty
                guard let data = data else {
                    responseSubject.onError(NSError(domain: "", code: -1, userInfo: nil))
                    responseSubject.onCompleted()
                    return
                }
                do {
                    let movieDetail = try JSONDecoder().decode(MovieDetailsDTO.self, from: data)
                    responseSubject.onNext(movieDetail)
                } catch {
                    do {
                        //error i can decode
                        let errorMessage = try JSONDecoder().decode(ErrorModel.self, from: data)
                        responseSubject.onError(errorMessage.error)
                    } catch {
                        //unexpected error
                        responseSubject.onError(error)
                    }
                }
                responseSubject.onCompleted()
            }
            task.resume()
            return responseSubject
        }
    }

