//
//  Weather.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import WANetworking
import WADatabase

struct Weather {
    let index: Int
    let cityName: String
    let temp: Int
    let humidity: Int
    let condition: String
    let code: Int
    let isDay: Bool
    let unixDate: Int
    let lat: Float
    let lon: Float
    
    init(from response: WeatherResponse) {
        self.cityName = response.location.name
        self.temp = Int(response.current.temp)
        self.humidity = response.current.humidity
        self.condition = response.current.condition.text
        self.code = response.current.condition.code
        self.isDay = response.current.isDay == 1
        self.unixDate = response.location.unixDate
        self.lat = response.location.lat
        self.lon = response.location.lon
        self.index = UUID().hashValue
    }
    
    init(from itemRO: WeatherItemRO) {
        self.cityName = itemRO.cityName
        self.temp = itemRO.temp
        self.humidity = itemRO.humidity
        self.condition = itemRO.condition
        self.code = itemRO.code
        self.isDay = itemRO.isDay
        self.unixDate = itemRO.unixDate
        self.lat = itemRO.lat
        self.lon = itemRO.lon
        self.index = itemRO.index
    }
}
