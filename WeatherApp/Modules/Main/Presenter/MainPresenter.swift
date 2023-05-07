//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

protocol MainPresentationLogic: AnyObject {
    func present(_ weather: Weather)
}

final class MainPresenter: MainPresentationLogic {
    
    weak var viewController: MainDisplayLogic?
    
    private let pictureWeatherManager: PictureWeatherManager
    
    private lazy var mapper: WeatherCellVOMapper = {
        return WeatherCellVOMapper()
    }()
    
    init(pictureWeatherManager: PictureWeatherManager) {
        self.pictureWeatherManager = pictureWeatherManager
    }
    
    func present(_ weather: Weather) {
        let gradientColor = pictureWeatherManager.getBackgroundGradientNames(by: weather.code, isDay: weather.isDay)
        let image = pictureWeatherManager.getWeatherPicture(by: weather.code, isDay: weather.isDay)
        let viewObject = mapper.map(from: weather, image: image, gradientColor: gradientColor)
        viewController?.set(viewObject: viewObject)
    }
    
}

