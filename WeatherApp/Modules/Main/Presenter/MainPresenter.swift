//
//  MainPresenter.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

protocol MainPresentationLogic: AnyObject {
    func present(_ weather: Weather)
    func presentAtEnd(_ weather: Weather, prevIndex: Int)
    func presentAll(_ allWeathers: [Weather])
    func presentAlert(title: String?, message: String)
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
        let viewObject = mapper.map(from: weather, image: image, gradientColor: gradientColor, index: weather.index)
        viewController?.replace(viewObject: viewObject)
    }
    
    func presentAtEnd(_ weather: Weather, prevIndex: Int) {
        let gradientColor = pictureWeatherManager.getBackgroundGradientNames(by: weather.code, isDay: weather.isDay)
        let image = pictureWeatherManager.getWeatherPicture(by: weather.code, isDay: weather.isDay)
        let viewObject = mapper.map(from: weather, image: image, gradientColor: gradientColor, index: prevIndex + 1)
        viewController?.append(viewObject: viewObject)
    }
    
    func presentAll(_ allWeathers: [Weather]) {
        
        var allViewObjects: [WeatherCellViewObject] = []
        for i in 0..<allWeathers.count {
            let weather = allWeathers[i]
            let gradientColor = pictureWeatherManager.getBackgroundGradientNames(by: weather.code, isDay: weather.isDay)
            let image = pictureWeatherManager.getWeatherPicture(by: weather.code, isDay: weather.isDay)
            allViewObjects.append(mapper.map(from: weather, image: image, gradientColor: gradientColor, index: i))
        }
        viewController?.set(allViewObjects: allViewObjects)
    }
    
    func presentAlert(title: String?, message: String) {
        viewController?.displayAlert(title: title, message: message)
    }
    
}

