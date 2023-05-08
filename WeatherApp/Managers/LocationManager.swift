//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    func getUserLocation (completion: @escaping ((CLLocation) -> Void)) {
        manager.delegate = self
        self.completion = completion
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorizedWhenInUse 🥲")
            manager.requestLocation()
        case .authorizedAlways:
            print("authorizedAlways 🥲")
            manager.requestLocation()
        case .denied:
            break
        case .notDetermined:
            print("notDetermined 🥲")
        case .restricted:
            print("restricted 🥲")
            break //??
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("2.1🥲")
        guard let location = locations.first else {
            return
        }
        print("2🥲")
        completion?(location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .notDetermined, .restricted:
            
            break //??
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
