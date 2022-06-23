//
//  LoggerExtension.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation

extension String {
    
    // Required for log tracking by the Logify CLI -> https://github.com/furkankaplan/Logify
    var logifyEncoder: String { self.replacingOccurrences(of: "\n", with: "@new-line@") }
}

extension Data {
    
    func prettyPrinted() -> String {
        (NSString(data: self, encoding: String.Encoding.utf8.rawValue) ?? "") as String
    }
    
}
