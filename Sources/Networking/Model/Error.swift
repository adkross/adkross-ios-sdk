//
//  ErrorModel.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation

struct ErrorModel: Decodable {
    
    var code: ErrorCode?
    
    var message: String?
    
}

enum ErrorCode: String, Decodable {
    
    // Request has invalid api key or app key to start SDK.
    case unauthorized = "UNAUTHORIZED"
    
    // Membership payments must be done regularly according its period. Customer sees `membershipExpire` if payment is not proceed and notice period passes.
    case membershipExpired = "MEMBERSHIP_EXPIRED"
    
    // Expected operation in API, for example ad click is not inserted by the database query, couldn't be done correctly because of some reason.
    case notOperated = "NOT_OPERATED"
    
}
