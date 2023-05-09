//
//  MainInteractor.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import WANetworking

protocol MainBuisnessLogic: AnyObject {
    func updateWeather(viewObject: WeatherCellViewObject)
    func addWeather(lat: Float, lon: Float, prevIndex: Int)
    func viewDidLoad()
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
    
    func viewDidLoad() {
        let allWeather = weatherManager.getAllWeather()
        locationManager.getUserLocation { [weak self] location in
            let lat = Float(location.coordinate.latitude)
            let lon = Float(location.coordinate.longitude)
            if allWeather.isEmpty {
                if InternetConnection.isConnected {
                    self?.loadWithEmptyCache(lat: lat, lon: lon)
                } else {
                    self?.presenter?.presentAlert(title: "Проблема с интернетом", message: "Попробуйте подключиться позже")
                }
            } else {
                self?.loadWithCache(allWeather, lat: lat, lon: lon)
            }
        }
    }
    
    func updateWeather(viewObject: WeatherCellViewObject) {
        if viewObject.index == 0 {
            locationManager.getUserLocation { [weak self] location in
                let latCurrent = Float(location.coordinate.latitude)
                let lonCurrent = Float(location.coordinate.longitude)
                self?.updateWithCurrentLocation(lat: latCurrent, lon: lonCurrent)
            }
        } else {
            self.updateWithPrevLocation(viewObject: viewObject)
        }
    }
    
    func addWeather(lat: Float, lon: Float, prevIndex: Int) {
        weatherManager.getWeatherByIndexCoordinate(index: prevIndex + 1, lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.presentAtEnd(weather, prevIndex: prevIndex)
            case .failure(let error):
                self?.presenter?.presentAlert(title: nil, message: error.rawValue)
            }
        }
    }
    
    private func updateWithCurrentLocation(lat: Float, lon: Float) {
        weatherManager.getWeatherByIndexCoordinate(index: 0, lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.present(weather)
            case .failure(_):
                break
            }
        }
    }
    
    private func updateWithPrevLocation(viewObject: WeatherCellViewObject) {
        weatherManager.getWeatherByIndexCoordinate(index: viewObject.index, lat: viewObject.lat, lon: viewObject.lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.present(weather)
            case .failure(_):
                break
            }
        }
    }
    private func loadWithEmptyCache(lat: Float, lon: Float) {
        weatherManager.getWeatherByIndexCoordinate(index: 0, lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.presentAll([weather])
            case .failure(let error):
                self?.presenter?.presentAlert(title: nil, message: error.rawValue)
            }
        }
    }
    
    private func loadWithCache(_ allWeather: [Weather], lat: Float, lon: Float) {
        weatherManager.getWeatherByIndexCoordinate(index: 0, lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                var updatedAllWeather = allWeather
                updatedAllWeather[0] = weather
                self?.presenter?.presentAll(updatedAllWeather)
            case .failure(let error):
                self?.presenter?.presentAlert(title: nil, message: error.rawValue)
            }
        }
    }
}
