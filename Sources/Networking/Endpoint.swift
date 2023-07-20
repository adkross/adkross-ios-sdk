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
    case campaingLoad(request: CampaignLoad.Request)
    case fireEvent(request: FireEvent.Request)
    
    var url: String {
        switch self {
        case .campaingLoad:
            return "\(Environment.host)\(Environment.Service.load)"
        case .fireEvent:
            return "\(Environment.host)\(Environment.Service.fireEvent)"
        }
    }
    
    var request: Encodable? {
        switch self {
        case .campaingLoad(let request):
            return request
        case .fireEvent(request: let request):
            return request
        }
    }
}
