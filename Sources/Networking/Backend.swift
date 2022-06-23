//
//  Backend.swift
//  
//
//  Created by Furkan Kaplan on 24.06.2022.
//

import Foundation

struct Backend {
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func check(token: String) {
        network.request(
            endpoint: AdkrossEndpoint.start,
            requestType: EmptyRequest.self,
            responseType: EmptyResponse.self) { response in
                
                switch response {
                case .success(let model):
                    break
                case .failure(let error):
                    break
                }
            }
    }
    
}

struct EmptyRequest: Encodable { }

struct EmptyResponse: Decodable { }
