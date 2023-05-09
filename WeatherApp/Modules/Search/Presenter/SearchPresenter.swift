//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func present(items: [SearchItem])
    func presentWeather(lat: Float, lon: Float)
    func presentAlert(title: String?, message: String)
}

final class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    func present(items: [SearchItem]) {
        viewController?.set(items: items)
        if items.isEmpty {
            viewController?.showEmptyState()
        }
    }
    
    func presentWeather(lat: Float, lon: Float) {
        viewController?.add(lat: lat, lon: lon)
    }
    
    func presentAlert(title: String?, message: String) {
        viewController?.displayAlert(title: title, message: message)
    }
}

