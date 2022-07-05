//
//  GenericResponse.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    
    var error: ErrorModel?
    
    var data: T?
    
}
