//
//  MovieDetailsEntity.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation

struct MovieDetailsEntity {
    let id : Int?
    let imdb_id : String?
    let overview : String?
    let release_date : String?
    let title : String?
    let genres : [GenresEntity]?
    let runtime : Int?
    let poster_path : String?
}

struct GenresEntity  {
    let id : Int?
    let name : String?
}
