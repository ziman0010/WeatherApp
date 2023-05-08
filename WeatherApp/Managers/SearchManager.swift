//
//  SearchManager.swift
//  WeatherApp
//
//  Created by Алексей Черанёв on 07.05.2023.
//

import UIKit
import WANetworking

final class SearchManager {
    
    private let restExecuter: RestExecutor
    
    init(restExecuter: RestExecutor) {
        self.restExecuter = restExecuter
    }
    
    func search(query: String, completion: @escaping (Result<[SearchItem], WAError>) -> Void) {
        restExecuter.performSearchGet(query: query) { result in
            switch result {
            case .success(let response):
                let items = response.map { SearchItem(from: $0) }
                completion(.success(items))
            case .failure(_):
                completion(.failure(WAError.smthWentWrong))
            }
        }
    }
}
