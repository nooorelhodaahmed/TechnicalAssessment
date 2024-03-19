//
//  Mapper+Extension.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation

extension MovieUseCase {
    
    func mapRecentMovie(from model: RecentMoviesDTO) -> [ResultsEntity] {
        mapRecentResult(from: model.results ?? [])
    }
    
    func mapRecentResult(from model: [ResultsDTO]) -> [ResultsEntity] {
        model.map {
            ResultsEntity(id: $0.id, poster_path: $0.poster_path, release_date: $0.release_date, title: $0.title)
        }
    }
}
