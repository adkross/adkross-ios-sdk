//
//  Logger.swift
//  
//
//  Created by Furkan Kaplan on 19.06.2022.
//

import Foundation
import OSLog

public protocol Logging {
    func logWith(error message: String)
    func logWith(info message: String)
    func logWith(fault message: String)
    func logWith(default message: String)
}

final public class Logger: Logging {
    
    private let osLog: OSLog
    
    public init(osLog: OS) {
        self.osLog = OSLog(subsystem: osLog.subsystem, category: osLog.category)
    }
    
    public func logWith(error message: String) {
        printLog(type: .error, message: message)
    }
    
    public func logWith(info message: String) {
        printLog(type: .info, message: message)
    }
    
    public func logWith(fault message: String) {
        printLog(type: .fault, message: message)
    }
    
    public func logWith(default message: String) {
        printLog(type: .default, message: message)
    }
    
}


extension Logger {
    
    public struct OS {
        let subsystem: String
        let category: String
        
        public init(subsystem: String, category: String) {
            self.subsystem = subsystem
            self.category = category
        }
    }
    
    private func printLog(type: OSLogType, message: String) {
        os_log(type, log: osLog, "%@", message.logifyEncoder)
    }
    
}
