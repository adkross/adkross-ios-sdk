//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 18.06.2022.
//

import Foundation

public struct Adkross {
    
    private static var backend: Backend?
    private static var token: String?
    
    public static func startWith(apiKey: String, appKey: String) {
        let logger = Logger(osLog: Logger.OS(subsystem: "com.adkross", category: "ios-sdk"))
        let parser = Parser(logger: logger)
        let network = HttpClient(
            apiKey: apiKey,
            appKey: appKey,
            logger: logger,
            parser: parser,
            encoder: JSONEncoder())
        
        backend = Backend(network: network)
    }
    
}

// MARK: - Network Calls

extension Adkross {
    
    public static func check() {
        Self.backend?.check(completion: { token in
            Self.token = token
        })
    }
}
