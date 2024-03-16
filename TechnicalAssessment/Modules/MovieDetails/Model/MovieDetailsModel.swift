//
//  MovieDetailsModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 15/03/2024.
//

import Foundation

struct MovieDetailsModel : Codable {
    let id : Int?
    let imdb_id : String?
    let overview : String?
    let release_date : String?
    let title : String?
    let genres : [Genres]?
    let runtime : Int?
    let poster_path : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imdb_id = "imdb_id"
        case overview = "overview"
        case release_date = "release_date"
        case title = "title"
        case genres = "genres"
        case runtime = "runtime"
        case poster_path = "poster_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imdb_id = try values.decodeIfPresent(String.self, forKey: .imdb_id)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime)
        poster_path = try values.decodeIfPresent(String.self, forKey: .poster_path)
    }
}

struct Genres : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
