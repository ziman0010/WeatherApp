//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import Foundation
import WADatabase

final class WeatherManager {
    
    private let weatherLoader: WeatherLoader
    private let weatherSaver: WeatherSaver
    private let weatherDAO: WeatherDAO
    
    init(weatherLoader: WeatherLoader,
         weatherSaver: WeatherSaver,
         weatherDAO: WeatherDAO) {
        
        self.weatherLoader = weatherLoader
        self.weatherSaver = weatherSaver
        self.weatherDAO = weatherDAO
    }
    
    func getWeatherByIndexCoordinate(index: Int, lat: Float, lon: Float, completion: @escaping ((Result<Weather, WAError>) -> Void)) {
        if let oldWeather = weatherDAO.obtainWeather(for: index) {
            
            if isNeedRealodWeather(with: oldWeather.unixDate) {
                weatherLoader.loadWeather(lat: lat, lon: lon) { [weak self] result in
                    switch result {
                    case .success(let badWeather):
                        self?.weatherSaver.save(weather: badWeather, index: index) { result in
                            switch result {
                            case .success(let savedWeather):
                                completion(.success(savedWeather))
                            case .failure(_):
                                completion(.failure(WAError.smthWentWrong))
                            }
                        }
                    case .failure(_):
                        completion(.failure(WAError.cannotLoadWeather))
                    }
                }
            } else {
                let currentWeather = Weather(from: oldWeather)
                completion(.success(currentWeather))
            }
            
        } else {
            weatherLoader.loadWeather(lat: lat, lon: lon) { [weak self] result in
                switch result {
                case .success(let badWeather):
                    self?.weatherSaver.save(weather: badWeather, index: index) { result in
                        switch result {
                        case .success(let savedWeather):
                            completion(.success(savedWeather))
                        case .failure(_):
                            completion(.failure(WAError.smthWentWrong))
                        }
                    }
                case .failure(_):
                    completion(.failure(WAError.cannotLoadWeather))
                }
            }
        }
    }
    
    func getAllWeather(completion: (([Weather]) -> Void)) {
        let allWeather = weatherDAO.obtainAllWeather().map { Weather(from: $0)}.sorted { $0.index < $1.index }
        completion(allWeather)
    }
    
    private func isNeedRealodWeather(with date: Int) -> Bool {
        let timeInterval = NSDate().timeIntervalSince1970
        
        if Int(timeInterval) -  date > 20 {
            return true
        } else {
            return false
        }
    }
}
