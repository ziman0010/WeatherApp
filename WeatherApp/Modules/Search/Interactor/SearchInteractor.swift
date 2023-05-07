//
//  SearchInteractor.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

protocol SearchBuisnessLogic: AnyObject {
    func search(query: String)
    func loadWeather(lat: Float, lon: Float)
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
        searchManager.search(query: query) { [weak self] result in
            switch result {
            case .success(let items):
                self?.presenter?.present(items: items)
            case .failure(let error):
                break
            }
        }
    }
    
    func loadWeather(lat: Float, lon: Float) {
        weatherManager.getWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.presenter?.present(weather: weather)
            case .failure(let error):
                break
            }
        }
    }
    
}
