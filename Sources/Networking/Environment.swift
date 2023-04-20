//
//  Environment.swift
//  
//
//  Created by Furkan Kaplan on 23.06.2022.
//

import Foundation

struct Environment {
    static let host: String = "https://api.adkross.com/sdk"
    
    struct Service {
        static let main: String = "/main"
        static let campaing: String = "/campaign"
        static let fireEvent: String = "/fire-event"
    }
}
