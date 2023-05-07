//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

protocol MainBuisnessLogic: AnyObject {
    func getCurrentWeather()
    func addWeather(weather: Weather)
}

final class MainInteractor: MainBuisnessLogic {
    
    var presenter: MainPresentationLogic?
    
    private let locationManager: LocationManager
    private let weatherManager: WeatherManager
    
    init(presenter: MainPresentationLogic,
         weatherManager: WeatherManager,
         locationManager: LocationManager) {
        
        self.presenter = presenter
        self.weatherManager = weatherManager
        self.locationManager = locationManager
    }
    
    func getCurrentWeather() {
        locationManager.getUserLocation { [weak self] location in
            let lat = Float(location.coordinate.latitude)
            let lon = Float(location.coordinate.longitude)
            self?.weatherManager.getWeather(lat: lat, lon: lon) { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.presenter?.present(weather)
                case .failure(let error):
                    break
                }
            }
        }
    }
    
    func addWeather(weather: Weather) {
        presenter?.present(weather)
    }
}
