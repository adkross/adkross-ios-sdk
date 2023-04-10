//
//  MainStartModel.swift
//  
//
//  Created by Furkan Kaplan on 30.06.2022.
//

import Foundation

struct MainStartModel {
    
    struct Request: Encodable { /* No request required. */ }
    
    struct Response: Decodable {
        var token: String?
    }
}
