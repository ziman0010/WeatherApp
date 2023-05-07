//
//  Host.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

enum Host {
    case weatherStack
    
    var rawValue: String {
        switch self {
        case .weatherStack:
            return "https://api.weatherapi.com/v1"
        }
    }
}
