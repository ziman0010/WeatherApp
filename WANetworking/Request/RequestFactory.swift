//
//  RequestFactory.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

final class RequestFactory {
    
    private var defaultParams = ["key" : "275db0f6c78040b2b97140537230605", "lang" : "ru"]
    
    func createWeatherGetRequest(query: String) -> Request {
        
        var params = defaultParams
        params["q"] = query
    
        let request = Request(method: .get, host: .weatherStack, path: .weather, headers: [:], params: params)
        
        return request
    }
    
    func createWeatherGetRequest(lat: Float, lon: Float) -> Request {
        
        var params = defaultParams
        params["q"] = "\(lat),\(lon)"
    
        let request = Request(method: .get, host: .weatherStack, path: .weather, headers: [:], params: params)
        
        return request
    }
    
    func createSearchGetRequest(query: String) -> Request {
        
        var params = defaultParams
        params["q"] = query
    
        let request = Request(method: .get, host: .weatherStack, path: .search, headers: [:], params: params)
        
        return request
    }
}
