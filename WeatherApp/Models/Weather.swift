//
//  Weather.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import WANetworking

struct Weather {
    let cityName: String
    let temp: Int
    let humidity: Int
    let condition: String
    let code: Int
    let isDay: Bool
    let unixDate: Int
    
    init(from response: WeatherResponse) {
        self.cityName = response.location.name
        self.temp = Int(response.current.temp)
        self.humidity = response.current.humidity
        self.condition = response.current.condition.text
        self.code = response.current.condition.code
        self.isDay = response.current.isDay == 1
        self.unixDate = response.location.unixDate
    }
}
