//
//  PLKFormMultipart.swift
//
//  Created by Sapien on 5/12/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit
import SwiftyJSON

public class PLKFormMultipart {
    
	public var task:URLSessionDataTask?
	
    let url:URL?
    let session:URLSession
    
    private var _formdata:Dictionary<String,Any>
    private var _header:Dictionary<String,String>?
    
    
    public init(url:String) {
        self.url    = URL(string: url)
        
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
        
        _formdata = Dictionary<String,Any>()
    }
    
    // -----------
    
    private func getRequest() -> URLRequest? {
        guard let url = self.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "post"
        
        if let header = _header {
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let boundary:String = PLKHash.uuid()
        
        request.addValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
        
        let body:NSMutableData = NSMutableData()
        
        for (key, value) in _formdata {
            
            if(value is String) {
                body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "%@\r\n", value as! String).data(using: String.Encoding.utf8.rawValue)!)
            }
            
            if(value is Int) {
                body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "%i\r\n", value as! Int).data(using: String.Encoding.utf8.rawValue)!)
            }
            
            if(value is Float) {
                body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "%f\r\n", value as! Float).data(using: String.Encoding.utf8.rawValue)!)
            }
            
            if(value is UIImage) {
                
                let imageData:Data = (value as! UIImage).jpegData(compressionQuality: 0.8)!
                
                body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@.jpg\"\r\n", key, PLKHash.uuid()).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(string: "Content-Type: image/jpeg\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
                body.append(imageData)
                body.append(NSString(string: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
            }
            
            if(value is NSData) {
                let tData:NSData = value as! NSData
                
                body.append(NSString(format: "--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(format: "Content-Disposition: form-data; name=\"%@\"; filename=\"%@.bin\"\r\n", key, PLKHash.uuid()).data(using: String.Encoding.utf8.rawValue)!)
                body.append(NSString(string: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
                body.append(tData as Data)
                body.append(NSString(string: "\r\n").data(using: String.Encoding.utf8.rawValue)!)
                
            }
            
        }
        
        body.append(NSString(format: "--%@--\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        request.httpBody = body as Data
        return request
    }

    
    
    
    public func setHeader(params:Dictionary<String,String>) -> PLKFormMultipart {
        _header = params
        return self
    }
    
    
    
    public func addFormDataString(name:String, data string:String) -> PLKFormMultipart {
        _formdata[name] = string
        return self
    }
    
    public func addFormDataInt(name:String, data number:Int) -> PLKFormMultipart {
        _formdata[name] = number
        return self
    }
    
    public func addFormDataFloat(name:String, data number:Float) -> PLKFormMultipart {
        _formdata[name] = number
        return self
    }
    
    public func addFormDataUIImage(name:String, data image:UIImage) -> PLKFormMultipart {
        _formdata[name] = image
        return self
    }
	
    public func addFormData(name:String, data image:NSData) -> PLKFormMultipart {
        _formdata[name] = image
        return self
    }
    
    
    public func executeWithData(completion:@escaping (_ data: Data?, _ response: URLResponse?, _ error:Error?) -> Void) {
        
        guard let request = self.getRequest() else {
            DispatchQueue.main.sync {
                completion(nil, nil, nil)
            }
            
            return
        }
        
        task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            DispatchQueue.main.sync {
                completion(data, response, error)
            }
        });
        
        task?.resume()
    }
    
    public func executeWithJSON(completion:@escaping (_ data: JSON?, _ response: URLResponse?, _ error:Error?) -> Void) {
        
        guard let request = self.getRequest() else {
            DispatchQueue.main.sync {
                completion(nil, nil, nil)
            }
            
            return
        }
        
        // print("REQ: \(request.url)")
        
        task = session.dataTask(with: request, completionHandler: {(data, response, error) in
            if(error != nil) {
                DispatchQueue.main.sync {
                    completion(nil, response, error)
                }
                
                return
            }
            
            /*
            if data != nil {
                let resd = String(data: data!, encoding: .utf8)
                print("RES: \(resd)")
            }
            */
            
            if let data = data, let json = PLKJSON.decode(data: data) {
                DispatchQueue.main.sync {
                    completion(json, response, error)
                }
                return
            }
            
            DispatchQueue.main.sync {
                completion(nil, response, error)
            }
        });
        
        task?.resume()
    }
    
    
}
