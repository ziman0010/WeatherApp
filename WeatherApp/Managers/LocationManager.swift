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
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.completion = completion
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.requestLocation()
        case .authorizedAlways:
            manager.requestLocation()
        case .denied:
            break
        case .notDetermined:
            break
        case .restricted:
            break
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
            NotificationCenter.default.post(name: NSNotification.Name("UnBlock"), object: nil)
            manager.requestLocation()
        case .denied, .notDetermined, .restricted:
            NotificationCenter.default.post(name: NSNotification.Name("Block"), object: nil)
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
