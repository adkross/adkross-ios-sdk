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
    case campaingLoad(request: CampaignLoadModel.Request)
    
    var url: String {
        switch self {
        case .mainStart:
            return "\(Environment.host)\(Environment.Service.main)/start"
        case .campaingLoad:
            return "\(Environment.host)\(Environment.Service.campaing)/load"
        }
    }
    
    var request: Encodable? {
        switch self {
        case .mainStart:
            return nil
        case .campaingLoad(let request):
            return request
        }
    }
    
}
