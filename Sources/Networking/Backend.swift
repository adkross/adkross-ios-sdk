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
    
    func check(completion: @escaping (String?) -> Void) {
        network?.request(
            endpoint: AdkrossEndpoint.mainStart(request: MainStartModel.Request()),
            requestType: MainStartModel.Request.self,
            responseType: MainStartModel.Response.self) { response in
                switch response {
                case .success(let model):
                    completion(model.token)
                case .failure(let error):
                    completion(nil)
                    break
                }
            }
    }
    
}
