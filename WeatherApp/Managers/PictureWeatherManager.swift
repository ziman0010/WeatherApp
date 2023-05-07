//
//  PictureWeatherManager.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit

final class PictureWeatherManager {
    
    
    func getWeatherPicture(by code: Int, isDay: Bool) -> String {
        switch code {
        case 1030:
            let imageDay = "sun_rain"
            let imageNight = "moon_and_rain"
            return isDay ? imageDay : imageNight
        case 1003:
            let imageDay = "few_clouds"
            let imageNight = "moon_clouds"
            return isDay ? imageDay : imageNight
        case 1006:
            let imageDay = "sun_clouds"
            let imageNight = "moon_clouds"
            return isDay ? imageDay : imageNight
        case 1000:
            let imageDay = "sun"
            let imageNight = "moon"
            return isDay ? imageDay : imageNight
        case 1279, 1282, 1273, 1087, 1276:
            return "thunder"
        case 1195, 1192, 1246, 1189, 1063, 1171:
            return "rain"
        case 1240, 1180, 1168, 1243, 1183, 1186, 1150, 1072, 1153:
            return "freezing_rain"
        case 1009:
            return "cloudy"
        case 1135:
            return "fog"
        case 1147:
            return "fog_snow"
        case 1225, 1237, 1069, 1066, 1222:
            return "snow"
        case 1264, 1207, 1258, 1261, 1249, 1255, 1252, 1198, 1201, 1204:
            return "freez_rain"
        case 1213, 1219, 1210, 1216:
            return "few_snow"
        case 1114, 1117:
            return "snow_wind"
        default:
            return "ic_default"
        }
    }
    
    func getBackgroundGradientNames(by code: Int, isDay: Bool) -> (String, String) {
        
//        let layer = CAGradientLayer()
//        layer.startPoint = CGPoint (x: 0,y: 0)
//        layer.endPoint = CGPoint (x: 1,y: 1)

        switch code {
        case 1003, 1006, 1000:
            if isDay {
                return ("sun_day_top", "sun_day_bottom")
            } else {
                return ("sun_night_top", "sun_night_bottom")
            }
        case 1030, 1279, 1282, 1273, 1087, 1276, 1195, 1192, 1246, 1189, 1063, 1171, 1240, 1180, 1168, 1243, 1183, 1186, 1150, 1072, 1153:
            return ("rain_top", "rain_bottom")
        case 1009, 1135, 1147:
            return ("fog_top", "fog_bottom")
        case 1225, 1237, 1069, 1066, 1222, 1264, 1207, 1258, 1261, 1249, 1255, 1252, 1198, 1201, 1204, 1213, 1219, 1210, 1216, 1114, 1117:
            return ("snow_top", "snow_bottom")
        default:
            return ("default_black", "default_black")
        }
    }
}
