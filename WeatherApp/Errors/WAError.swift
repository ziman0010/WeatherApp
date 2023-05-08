//
//  WAError.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import Foundation

enum WAError: String, Error {
    case denyLocation = "Нет доступа к геопозиции"
    case notDeterminedLocation = "Геопозиция не определена"
    case smthWentWrong = "Что-то пошло не так..."
    case cannotLoadWeather = "Не удалось загрузить погоду"
    case notFoundItems = "Не найдены города"
}
