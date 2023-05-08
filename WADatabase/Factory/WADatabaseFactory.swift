//
//  WADatabaseFactory.swift
//  WADatabase
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import Foundation

public final class WADatabaseFactory {
    public static let shared = WADatabaseFactory()
    
    private init() {}
    
    public func makeRealmManager() -> RealmManager {
        return RealmManager.shared
    }
    
    public func makeWeatherDAO() -> WeatherDAO {
        return WeatherDAO()
    }
    
}
    
