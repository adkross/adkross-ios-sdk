//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 30.06.2022.
//

import Foundation

struct CheckModel {
    
    struct Request: Encodable {
        
    }
    
    struct Response: Decodable {
        var token: String?
    }
    
}
