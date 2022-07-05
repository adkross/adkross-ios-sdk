//
//  Backend.swift
//  
//
//  Created by Furkan Kaplan on 24.06.2022.
//

import Foundation

struct Backend {
    
    private let network: Networking?
    
    private init() {
        // Not allowed to create an instance with default constructor
        network = nil
    }
    
    init(network: Networking) {
        self.network = network
    }
    
    func check(completion: @escaping (String) -> Void) {
        network?.request(
            endpoint: AdkrossEndpoint.start(request: CheckModel.Request()),
            requestType: CheckModel.Request.self,
            responseType: CheckModel.Response.self) { response in
                
                switch response {
                case .success(let model):
                    guard let token = model.token else { return }
                    
                    completion(token)
                case .failure(let error):
                    break
                }
            }
    }
    
}

struct EmptyRequest: Encodable { }

struct EmptyResponse: Decodable { }
