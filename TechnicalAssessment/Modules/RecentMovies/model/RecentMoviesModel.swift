//
//  RecentMoviesModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation

struct RecentMoviesModel : Codable {
    let page : Int?
    let results : [Results]?
    let total_pages : Int?
    let total_results : Int?
}
struct Results : Codable {
    let id : Int?
    let poster_path : String?
    let release_date : String?
    let title : String?
}

