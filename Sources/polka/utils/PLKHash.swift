//
//  PLKHash.swift
//
//  Created by Sapien on 5/12/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import Foundation

public class PLKHash: NSObject {
    
    public static func uuid() -> String! {
        return NSUUID().uuidString
    }
    
    public static func base64Encode(input:String!) -> String! {
        let data:Data = input.data(using: String.Encoding.utf8)!
        return data.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    }
    
	public static func base64Decode(input:String!) -> String! {
	        let data:Data? = Data(base64Encoded: input, options: Data.Base64DecodingOptions.init(rawValue: 0))
        
	        if(data != nil) {
	            var string:String? = String(data: data!, encoding: .utf8)
            
	            if(string == nil) {
	                string = String(data: data!, encoding: .isoLatin1)
	            }
            
	            if(string == nil) {
	                string = String(data: data!, encoding: .isoLatin2)
	            }
            
	            if(string == nil) {
	                string = String(data: data!, encoding: .ascii)
	            }
            
	            if(string != nil) {
	                return string!
	            }
	        }
        
	        return ""
	    }
    
}
