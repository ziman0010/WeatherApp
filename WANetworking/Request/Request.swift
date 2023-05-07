//
//  Request.swift
//  WANetworking
//
//  Created by Алексей Черанёв on 06.05.2023.
//

import Alamofire

public struct Request {
    let method: HTTPMethod
    let host: Host
    let path: Endpoint
    let headers: [String: String]
    let params: [String: Any]
    
    var requestURL: String {
        host.rawValue + path.rawValue
    }
}
