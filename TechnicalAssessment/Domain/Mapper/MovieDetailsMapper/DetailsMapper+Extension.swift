//
//  DetailsMapper+Extension.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation

extension MovieDetailsUseCase {
    
    func mapMovieDetails(from model: MovieDetailsDTO) -> MovieDetailsEntity {
        MovieDetailsEntity(id: model.id ?? 0, imdb_id: model.imdb_id ?? "" , overview: model.overview ?? "", release_date: model.release_date ?? "", title: model.title ?? "", genres: mapGeneres(from: model.genres ?? []) , runtime: model.runtime ?? 0, poster_path: model.poster_path ?? "")
    }
    
    func mapGeneres(from model: [GenresDTO]) -> [GenresEntity] {
        model.map {
            GenresEntity(id: $0.id, name: $0.name)
        }
    }
}
