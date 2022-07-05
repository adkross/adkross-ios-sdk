//
//  MainCheckModel.swift
//  
//
//  Created by Furkan Kaplan on 30.06.2022.
//

import Foundation

struct MainStartModel {
    
    struct Request: Encodable {
        
    }
    
    struct Response: Decodable {
        var token: String?
    }
    
}
