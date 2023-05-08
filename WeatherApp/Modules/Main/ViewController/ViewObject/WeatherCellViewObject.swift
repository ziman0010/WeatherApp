//
//  WeatherCellViewObject.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

struct WeatherCellViewObject {
    let index: Int
    let lat: Float
    let lon: Float
    let cityName: String
    let date: String
    let temp: String
    let humidity: String
    let condition: String
    let image: String
    let gradientColor: (String, String)
}
    
