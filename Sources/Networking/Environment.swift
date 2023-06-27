//
//  Environment.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

struct Environment {
    static let host: String = "http://localhost:8080/sdk" // "https://api.adkross.com/sdk"
    
    struct Service {
        static let load: String = "/load"
        static let fireEvent: String = "/fire-event"
    }
}
