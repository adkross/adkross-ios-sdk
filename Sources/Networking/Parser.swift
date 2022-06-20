//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation

protocol Parsing {
    func parseResponse<ResponseModel: Decodable>(data: Data, forType type: ResponseModel.Type, completion: @escaping(GenericResponseModel<ResponseModel>) -> Void)
}

struct Parser: Parsing {
    
    private let logger: Logging
    
    init(logger: Logging) {
        self.logger = logger
    }
    
    func parseResponse<ResponseModel>(data: Data, forType type: ResponseModel.Type, completion: @escaping (GenericResponseModel<ResponseModel>) -> Void) where ResponseModel : Decodable {
        do {
            let value = try JSONDecoder().decode(GenericResponseModel<ResponseModel>.self, from: data)
            completion(value)
        } catch {
            logger.logWith(fault: "JSON decoding issue as response parsing.")
        }
    }
    
}
