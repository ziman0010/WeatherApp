//
//  WeatherCellVOMapper.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

final class WeatherCellVOMapper {
    
    func map(from weather: Weather, image: String, gradientColor: (String, String)) -> WeatherCellViewObject {
        
        let cityName = weather.cityName
        let temp = (weather.temp > 0 ? "+\(weather.temp)" : "\(weather.temp)") + "°"
        
        let humidity = "Влажность: \(weather.humidity)%"
        let condition = weather.condition
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM"
        let date = Date(timeIntervalSince1970: TimeInterval(weather.unixDate))
        let dateString = formatter.string(from: date)
        return WeatherCellViewObject(cityName: cityName,
                                     date: dateString,
                                     temp: temp,
                                     humidity: humidity,
                                     condition: condition,
                                     image: image,
                                     gradientColor: gradientColor)
    }
}
