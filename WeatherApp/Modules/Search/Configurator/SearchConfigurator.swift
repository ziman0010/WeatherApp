//
//  SearchConfigurator.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

final class SearchConfigurator {
    
    func configure(viewController: SearchViewController, onAddAction: @escaping ((Float, Float) -> Void)) {
        let factory = WAFactory.shared
        
        let presenter = SearchPresenter()
        presenter.viewController = viewController
        
        let searchManager = factory.makeSearchManager()
        let weatherManager = factory.makeWeatherManager()
        
        let interactor = SearchInteractor(searchManager: searchManager, weatherManager: weatherManager)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        viewController.onAddAction = onAddAction
    }
}
