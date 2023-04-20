//
//  Backend.swift
//  
//
//  Created by Furkan Kaplan on 24.06.2022.
//

import Foundation

struct Backend {
    private let network: Networking
    private let logger: Logging

    init(
        network: Networking,
        logger: Logging
    ) {
        self.network = network
        self.logger = logger
    }
    
    func check(
        completion: @escaping (String?) -> Void
    ) {
        network.request(
            endpoint: AdkrossEndpoint.mainStart(
                request: MainStartModel.Request()
            ),
            requestType: MainStartModel.Request.self,
            responseType: MainStartModel.Response.self
        ) { response in
            switch response {
            case .success(let model):
                logger.logWith(info: "Adkross SDK started successfully.")
                completion(model.token)
            case .failure:
                completion(nil)
                logger.logWith(error: "Token not received.")
            }
        }
    }
    
    func load(
        campaignId: String? = nil,
        completion: @escaping(GenericResponse<CampaignLoadModel.Response>) -> Void
    ) {
        let request = CampaignLoadModel.Request(
            campaignId: campaignId
        )

        network.request(
            endpoint: AdkrossEndpoint.campaingLoad(
                request: request
            ),
            requestType: CampaignLoadModel.Request.self,
            responseType: GenericResponse<CampaignLoadModel.Response>.self
        ) { response in
            switch response {
            case .success(let model):
                logger.logWith(info: "Campaign loaded successfully.")
                completion(model)
            case .failure:
                logger.logWith(error: "Campaign not loaded properly. Ad will not be shown.")
            }
        }
    }
}
