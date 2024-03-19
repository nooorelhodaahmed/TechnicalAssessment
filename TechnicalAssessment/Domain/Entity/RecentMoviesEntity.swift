//
//  RecentMoviesEntity.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 17/03/2024.
//

import Foundation

struct RecentMoviesEntity {
    let results : [ResultsEntity]?
}

struct ResultsEntity {
    let id : Int?
    let poster_path : String?
    let release_date : String?
    let title : String?
}
