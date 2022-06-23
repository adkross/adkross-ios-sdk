//
//  File.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

struct HttpHeader {
    
    static func get(with apiKey: String) -> [String : String] {
        return ["API_KEY" : apiKey]
    }
    
}
