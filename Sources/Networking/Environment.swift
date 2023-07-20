//
//  Environment.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

struct Environment {
    static let host: String = "https://api.adkross-sdk.com/sdk"
    
    struct Service {
        static let load: String = "/load"
        static let fireEvent: String = "/fire-event"
    }
}
