//
//  WANetworkingFactory.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Foundation

public final class WANetworkingFactory {
    
    public static let shared = WANetworkingFactory()
    
    private init() {}
    
    private let requestFactory = RequestFactory()
    
    public func makeRestExecutor() -> RestExecutor {
        return RestExecutor(requestFactory: requestFactory)
    }
}
