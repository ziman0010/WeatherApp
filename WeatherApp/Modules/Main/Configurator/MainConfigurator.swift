//
//  MainConfigurator.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation
import CoreLocation

final class MainConfigurator {
    
    func configure(viewController: MainViewController) {
        let factory = WAFactory.shared
        
        let weatherManager = factory.makeWeatherManager()
        
        let pictureWeatherManager = factory.makePictureWeatherManager()
        
        let presenter = MainPresenter(pictureWeatherManager: pictureWeatherManager)
        presenter.viewController = viewController
        
        let locationManager = factory.makeLocationManager()
        let interactor = MainInteractor(presenter: presenter, weatherManager: weatherManager, locationManager: locationManager)
        interactor.presenter = presenter
        
        viewController.interactor = interactor
    }
}
