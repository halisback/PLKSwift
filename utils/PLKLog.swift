//
//  PLKLog.swift
//
//  Created by Sapien on 4/14/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import Foundation

public enum PLKLogLevel : Int {
    case ERROR
    case INFO
    case DEBUG
    case OFF
}

public class PLKLog: NSObject {
    
    public static var level:PLKLogLevel = .DEBUG
    
    public static func error(string: String?) {
        if(string == nil) {return}
        
        switch (level) {
        case .ERROR, .INFO, .DEBUG:
            print(string)
            break
        default:
            break
        }
    }
    
    public static func info(string: String?) {
        if(string == nil) {return}
        
        switch (level) {
        case .INFO, .DEBUG:
            print(string)
            break
        default:
            break
        }
    }
    
    public static func debug(string: String?) {
        if(string == nil) {return}
        
        switch (level) {
        case .DEBUG:
            print(string)
            break
        default:
            break
        }
    }
    
}
