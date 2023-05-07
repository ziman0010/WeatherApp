//
//  SearchItem.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import WANetworking

struct SearchItem {
    let name: String
    let lat: Float
    let lon: Float
    
    init(from response: SearchResponse) {
        self.name = response.name
        self.lat = response.lat
        self.lon = response.lon
    }
}
