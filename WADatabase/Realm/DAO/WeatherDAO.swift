//
//  WeatherDAO.swift
//  WADatabase
//
//  Created by Алексей Черанёв on 08.05.2023.
//
import Foundation
import RealmSwift

public final class WeatherDAO {
    
    private var realm: Realm? {
        return Realm.instance
    }
    
    public func obtainAllWeather() -> [WeatherItemRO] {
        guard let allWeather = realm?.objects(WeatherItemRO.self).toArray() else {
            //??
            return []
        }
        
        print("DAOobtainAllWeather🥲")
        return allWeather
    }
    
    public func obtainWeather(for index: Int) -> WeatherItemRO? {
        return realm?.object(ofType: WeatherItemRO.self, forPrimaryKey: index)
    }
}
