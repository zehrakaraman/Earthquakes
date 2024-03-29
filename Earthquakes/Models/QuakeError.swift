//
//  QuakeError.swift
//  Earthquakes
//
//  Created by Zehra on 21.01.2023.
//

import Foundation

enum QuakeError: Error {
    case missingData
    case networkError
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching quake data over the network.", comment: "")
        }
    }
}
