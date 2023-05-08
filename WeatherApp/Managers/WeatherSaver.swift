//
//  WeatherSaver.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import Foundation
import WADatabase

final class WeatherSaver {
    
    private let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func save(weather: Weather, index: Int, completion: @escaping (Result<Weather, Error>) -> Void) {
        
        let weatherItemRO = WeatherItemRO(index: index,
                                          cityName: weather.cityName,
                                          temp: weather.temp,
                                          humidity: weather.humidity,
                                          condition: weather.condition,
                                          code: weather.code,
                                          isDay: weather.isDay,
                                          unixDate: weather.unixDate,
                                          lat: weather.lat,
                                          lon: weather.lon)
        realmManager.write(
            operation: { realm in
                if let oldObject = realm.object(ofType: WeatherItemRO.self, forPrimaryKey: index)
                {
                    realm.delete(oldObject)
                    realm.add(weatherItemRO)
                } else {
                    realm.add(weatherItemRO)
                }
            },
            completion: { result in
                switch result {
                case .success:
                    let savedWeather = Weather(from: weatherItemRO)
                    completion(.success(savedWeather))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }
}
