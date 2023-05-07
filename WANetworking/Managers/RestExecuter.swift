//
//  RestExecuter.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation
import Alamofire

public final class RestExecutor {
    
    private let requestFactory: RequestFactory
    
    init(requestFactory: RequestFactory) {

        self.requestFactory = requestFactory
    }
    
    public func performSearchGet(query: String, completion: @escaping ((Result<[SearchResponse], Error>) -> Void)) {
        
        let request = requestFactory.createSearchGetRequest(query: query)
        execute(request, completion)
    }
    
    public func performWeatherGet(query: String, completion: @escaping ((Result<WeatherResponse, Error>) -> Void)) {
        
        let request = requestFactory.createWeatherGetRequest(query: query)
        execute(request, completion)
    }
    
    public func performWeatherGet(lat: Float, lon: Float, completion: @escaping ((Result<WeatherResponse, Error>) -> Void)) {
        
        let request = requestFactory.createWeatherGetRequest(lat: lat, lon: lon)
        execute(request, completion)
    }
    
    private func execute<T: Decodable>(_ request: Request, _ completion: @escaping ((Result<T, Error>) -> Void)) {
        let requestURL = request.requestURL
        let method = request.method
        let headers = HTTPHeaders(request.headers)
        let params = request.params
        
        AF.request(requestURL, method: method, parameters: params, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(T.self, from: data)
                        completion(.success(response))
                    } catch (let error) {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
