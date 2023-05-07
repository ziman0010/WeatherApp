//
//  EndPoint.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

enum Endpoint {
    case weather
    case search
    
    var rawValue: String {
        switch self {
        case .weather:
            return "/current.json"
        case .search:
            return "/search.json"
        }
    }
}
