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
}

// MARK: - Network Calls

extension Backend {

    func load(
        campaignKey: String? = nil,
        completion: @escaping NetworkResult<CampaignLoad.Response>
    ) {
        let request = CampaignLoad.Request(
            campaignKey: campaignKey
        )

        network.request(
            endpoint: AdkrossEndpoint.campaingLoad(
                request: request
            ),
            requestType: CampaignLoad.Request.self,
            responseType: CampaignLoad.Response.self
        ) { response in
            switch response {
            case .success(let model):
                completion(.success(model))
            case .failure(let message):
                completion(.failure(message))
            }
        }
    }

    func fireEvent(
        campaignKey: String,
        analyticEventType: EventType,
        completion: @escaping NetworkResult<FireEvent.Response>
    ) {
        let request = FireEvent.Request(
            analyticEventType: analyticEventType,
            campaignKey: campaignKey
        )

        network.request(
            endpoint: AdkrossEndpoint.fireEvent(
                request: request
            ),
            requestType: FireEvent.Request.self,
            responseType: FireEvent.Response.self
        ) { response in
            switch response {
            case .success(let model):
                completion(.success(model))
            case .failure(let message):
                completion(.failure(message))
            }
        }
    }
}
