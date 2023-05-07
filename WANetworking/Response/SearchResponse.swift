//
//  SearchResponse.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

public struct SearchResponse: Decodable {
    public let name: String
    public let lat: Float
    public let lon: Float
}
