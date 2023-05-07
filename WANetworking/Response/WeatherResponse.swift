//
//  SearchResponse.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

public struct WeatherResponse: Decodable {
    
    public let location: WeatherLocationResponse
    public let current:  WeatherCurrentResponse
}

public struct WeatherLocationResponse: Decodable {
    public let name: String
    public let unixDate: Int
    
    private enum CodingKeys: String, CodingKey {
        case unixDate = "localtime_epoch"
        case name
    }
}

public struct WeatherCurrentResponse: Decodable {
    public let temp: Float
    public let condition: WeatherConditionResponse
    public let humidity: Int
    public let isDay: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case isDay = "is_day"
        case condition, humidity
    }
}

public struct WeatherConditionResponse: Decodable {
    public let text: String
    public let icon: String
    public let code: Int
}
