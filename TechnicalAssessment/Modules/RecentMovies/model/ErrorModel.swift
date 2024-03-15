//
//  ErrorModel.swift
//  TechnicalAssessment
//
//  Created by norelhoda on 14/03/2024.
//

import Foundation

struct ErrorModel: Decodable {
    let success: Bool
    let error: ErrorData
}

struct ErrorData: Decodable {
    let type: String
}

extension ErrorData: LocalizedError {
    var errorDescription: String? {
        return type
    }
}
