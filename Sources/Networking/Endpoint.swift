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
    
    case start(request: CheckModel.Request)
    
    var url: String {
        switch self {
        case .start:
            return "\(Environment.host)\(Environment.Service.start)"
        }
    }
    
    var request: Encodable? {
        switch self {
        case .start(let request):
            return request
        }
    }
    
}
