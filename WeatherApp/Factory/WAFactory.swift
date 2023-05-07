//
//  WAFactory.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import WANetworking

final class WAFactory {
    static let shared = WAFactory()
    
    private init() {}
    
    func makeWeatherManager() -> WeatherManager {
        let restExecuter = WANetworkingFactory.shared.makeRestExecutor()
        let weatherManager = WeatherManager(restExecuter: restExecuter)
        return weatherManager
    }
    
    func makeLocationManager() -> LocationManager {
        return LocationManager()
    }
    
    func makePictureWeatherManager() -> PictureWeatherManager {
        return PictureWeatherManager()
    }
    
    func makeSearchManager() -> SearchManager {
        let restExecuter = WANetworkingFactory.shared.makeRestExecutor()
        return SearchManager(restExecuter: restExecuter)
    }
}
