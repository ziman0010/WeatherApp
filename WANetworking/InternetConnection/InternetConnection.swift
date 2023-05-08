//
//  InternetConnection.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import Alamofire

public struct InternetConnection {
    
    private static let reachabilityManager = NetworkReachabilityManager.default
    
    public static var isConnected: Bool {
        return reachabilityManager?.isReachable ?? true
    }
}
