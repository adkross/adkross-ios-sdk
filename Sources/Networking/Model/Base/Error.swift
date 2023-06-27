//
//  ErrorModel.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation
import Alamofire

struct ErrorModel: Decodable, Error {
    let message: String?
}
