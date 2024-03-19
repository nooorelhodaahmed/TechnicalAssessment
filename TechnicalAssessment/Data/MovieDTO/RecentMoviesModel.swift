//
//  RecentMoviesModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation

struct RecentMoviesDTO : Codable {
    let page : Int?
    let results : [ResultsDTO]?
    let total_pages : Int?
    let total_results : Int?
}

struct ResultsDTO : Codable {
    let id : Int?
    let poster_path : String?
    let release_date : String?
    let title : String?
}

