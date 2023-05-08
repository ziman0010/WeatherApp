//
//  WAFactory.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import WANetworking
import WADatabase

final class WAFactory {
    static let shared = WAFactory()
    
    private init() {}
    
    func makeWeatherManager() -> WeatherManager {
        let factory = WAFactory.shared
        
        let weatherLoader = factory.makeWeatherLoader()
        let weatherSaver = factory.makeWeatherSaver()
        let weatherDAO = WADatabaseFactory.shared.makeWeatherDAO()
        
        let weatherManager = WeatherManager(weatherLoader: weatherLoader,
                                            weatherSaver: weatherSaver,
                                            weatherDAO: weatherDAO)
        return weatherManager
    }
    
    func makeWeatherLoader() -> WeatherLoader {
        let restExecuter = WANetworkingFactory.shared.makeRestExecutor()
        return WeatherLoader(restExecuter: restExecuter)
    }
    
    func makeWeatherSaver() -> WeatherSaver {
        let realmManager = WADatabaseFactory.shared.makeRealmManager()
        return WeatherSaver(realmManager: realmManager)
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
