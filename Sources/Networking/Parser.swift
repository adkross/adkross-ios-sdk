//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation

protocol Parsing {
    func parseResponse<Response: Decodable>(
        data: Data,
        forType type: Response.Type,
        completion: @escaping(GenericResponse<Response>) -> Void
    )
}

struct Parser: Parsing {
    private let logger: Logging
    
    init(
        logger: Logging
    ) {
        self.logger = logger
    }
    
    func parseResponse<Response>(
        data: Data,
        forType type: Response.Type,
        completion: @escaping (GenericResponse<Response>) -> Void
    ) where Response : Decodable {
        do {
            let value = try JSONDecoder().decode(GenericResponse<Response>.self, from: data)
            completion(value)
        } catch {
            logger.logWith(fault: "JSON decoding issue as response parsing.")
        }
    }
}
