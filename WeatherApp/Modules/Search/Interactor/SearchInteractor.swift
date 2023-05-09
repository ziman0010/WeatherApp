//
//  SearchInteractor.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import WANetworking

protocol SearchBuisnessLogic: AnyObject {
    func search(query: String)
    func addWeather(lat: Float, lon: Float)
}

final class SearchInteractor: SearchBuisnessLogic {
    
    var presenter: SearchPresentationLogic?
    
    private let searchManager: SearchManager
    private let weatherManager: WeatherManager
    
    init(searchManager: SearchManager, weatherManager: WeatherManager) {
        self.searchManager = searchManager
        self.weatherManager = weatherManager
    }
    
    func search(query: String) {
        if InternetConnection.isConnected {
            searchManager.search(query: query) { [weak self] result in
                switch result {
                case .success(let items):
                    self?.presenter?.present(items: items)
                case .failure(_):
                    break
                }
            }
        } else {
            presenter?.presentAlert(title: nil, message: "Отсутствует подключение к интернету")
        }
    }
    
    func addWeather(lat: Float, lon: Float) {
        presenter?.presentWeather(lat: lat, lon: lon)
    }
}
