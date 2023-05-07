//
//  SearchPresenter.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

protocol SearchPresentationLogic: AnyObject {
    func present(items: [SearchItem])
    func present(weather: Weather)
}

final class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    func present(items: [SearchItem]) {
        viewController?.set(items: items)
    }
    
    func present(weather: Weather) {
        viewController?.add(weather: weather)
    }
}

