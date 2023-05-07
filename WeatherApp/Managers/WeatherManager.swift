//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import WANetworking

final class WeatherManager {
    
    private let restExecuter: RestExecutor
    
    init(restExecuter: RestExecutor) {
        self.restExecuter = restExecuter
    }
    
    func getWeather(name: String, completion: @escaping ((Result<Weather, Error>) -> ())) {
        restExecuter.performWeatherGet(query: name) { result in
            switch result {
            case .success(let response):
                let weather = Weather(from: response)
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeather(lat: Float, lon: Float, completion: @escaping ((Result<Weather, Error>) -> ())) {
        restExecuter.performWeatherGet(lat: lat, lon: lon) { result in
            switch result {
            case .success(let response):
                let weather = Weather(from: response)
                completion(.success(weather))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
