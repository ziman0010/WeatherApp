//
//  WeatherItemRO.swift
//  WADatabase
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation
import RealmSwift

public final class WeatherItemRO: Object {
    @Persisted public var cityName: String = ""
    @Persisted(primaryKey: true) public var index: Int = UUID().hashValue
    @Persisted public var temp: Int = 0
    @Persisted public var humidity: Int = 0
    @Persisted public var condition: String = ""
    @Persisted public var code: Int = 0
    @Persisted public var isDay: Bool = false
    @Persisted public var unixDate: Int = 0
    @Persisted public var lat: Float = 0.0
    @Persisted public var lon: Float = 0.0
    
    public convenience init(index: Int,
                            cityName: String,
                            temp: Int,
                            humidity: Int,
                            condition: String,
                            code: Int,
                            isDay: Bool,
                            unixDate: Int,
                            lat: Float,
                            lon: Float) {
        
        self.init()
        self.index = index
        self.cityName = cityName
        self.temp = temp
        self.humidity = humidity
        self.condition = condition
        self.code = code
        self.isDay = isDay
        self.unixDate = unixDate
        self.lat = lat
        self.lon = lon
    }
}
