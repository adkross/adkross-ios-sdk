//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 18.06.2022.
//

import Foundation

// MARK: - SDK Initialization

public class Adkross {
    private let backend: Backend
    private var token: String?

    public static var shared: Adkross {
        guard let adkross = adkross else {
            fatalError("Adkross SDK not initialized")
        }
        
        return adkross
    }
    private static var adkross: Adkross?
    
    private init(
        backend: Backend
    ) {
        self.backend = backend
    }

    // MARK: -
    
    static func setDefaultInstance(
        _ adkross: Adkross
    ) {
        Self.adkross = adkross
    }
}

// MARK: - Configuratiın Adkross

public extension Adkross {
    
    static func startWith(
        apiKey: String,
        appKey: String
    ) {
        let logger = Logger(
            osLog: Logger.OS(
                subsystem: "com.adkross",
                category: "ios-sdk"
            )
        )
        let parser = Parser(
            logger: logger
        )
        let network = HttpClient(
            apiKey: apiKey,
            appKey: appKey,
            logger: logger,
            parser: parser,
            encoder: JSONEncoder()
        )
        let backend = Backend(
            network: network,
            logger: logger
        )
        let adkross = Adkross(
            backend: backend
        )
                
        setDefaultInstance(adkross)
    }
}

// MARK: - Network Calls

extension Adkross {
    
    func check() {
        backend.check(completion: { token in
            self.token = token
        })
    }
    
    func load(
        campaignId: String? = nil,
        completion: @escaping(GenericResponse<CampaignLoadModel.Response>) -> Void
    ) {
        backend.load(
            campaignId: campaignId,
            completion: completion
        )
    }
}
