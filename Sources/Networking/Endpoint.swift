//
//  Endpoint.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

protocol Endpoint {

    var url: String { get }
    
    var request: Encodable? { get }
            
}

enum AdkrossEndpoint: Endpoint {
    
    case mainStart(request: MainStartModel.Request)
    
    var url: String {
        switch self {
        case .mainStart:
            return "\(Environment.host)\(Environment.Service.main)/start"
        }
    }
    
    var request: Encodable? {
        switch self {
        case .mainStart(let request):
            return request
        }
    }
    
}
