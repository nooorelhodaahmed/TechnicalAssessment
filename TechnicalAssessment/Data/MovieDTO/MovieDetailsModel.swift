//
//  MovieDetailsModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import Foundation

struct MovieDetailsDTO : Codable {
    let id : Int?
    let imdb_id : String?
    let overview : String?
    let release_date : String?
    let title : String?
    let genres : [GenresDTO]?
    let runtime : Int?
    let poster_path : String?
}

struct GenresDTO : Codable {
    let id : Int?
    let name : String?
}
