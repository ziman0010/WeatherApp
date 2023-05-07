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
        case .authorizedWhenInUse, .authorizedAlways:
            manager.requestLocation()
        case .denied, .notDetermined, .restricted:
            break //??
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        completion?(location)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        case .denied, .notDetermined, .restricted:
            break //??
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
