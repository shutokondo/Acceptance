//
//  Phone.swift
//  Acceptance
//
//  Created by 根東秀都 on 2015/12/19.
//  Copyright © 2015年 shuto kondo. All rights reserved.
//

import Foundation
import AVFoundation
import Alamofire

let SPDefaultClientName:String = "Phone"
let SPBaseCapabilityTokenUrl:String = "http://38a7537b.ngrok.com/auth"
let SPTwiMLAppSid:String = "APe0ed95fff0a3ccbcc0fad80888b1fbd4"

class Phone: NSObject {
    
    var device:TCDevice!
    var connection:TCConnection!
    
    //キャパビリティトークンのリクエストに使うURLをbuild
    //そのURLに対してHTTPリクエストの作成
    func login() {
        let url:String = self.getCapabilityTokenUrl()
        print(url)
        
        //キャパビリティトークンを取得する処理
        //deviceをcreateする準備整う
        
        Alamofire.request(.POST, url)
            .responseString { response in
                if (response.result.error != nil) {
                    return
                }
                print(response.result.value)
                let token = response.result.value
                
                if (response.result.error == nil && token != "") {
                    if (self.device == nil) {
                        self.device = TCDevice(capabilityToken: token, delegate: nil)
                    } else {
                        self.device!.updateCapabilityToken(token)
                    }
                } else if (response.result.error != nil && response.result.value != nil) {
                    //error message
                } else if (response.result.error != nil) {
                    
                }
        }
    }
    
        
    func getCapabilityTokenUrl() -> String {
        
        var querystring:String = String()
        
        //parameter
        querystring += String(format:"?sid=%@", SPTwiMLAppSid)
        querystring += String(format:"&name=%@", SPDefaultClientName)
        
        return String(format:SPBaseCapabilityTokenUrl + querystring)
    }
    
    func connectWithParams(params dictParams:Dictionary<String, String> = Dictionary<String,String>()) {
        //取得したキャパビリティトークンが期限切れでないかチェック
        if (!self.capabilityTokenValid()) {
            self.login()
        }
        print("============device============")
        print(self.device)
        print(dictParams)
        self.connection = self.device?.connect(dictParams, delegate: nil)
        
        
        //        let swiftRequest = SwiftRequest()
        //        let data = [
        //            "authenticity_token" : "AP4cae6d4c003c76401f7cbfe0c020c1cc"
        //        ]
        //        swiftRequest.post("http://67b7d3a4.ngrok.com/dial", data: data, callback: { (error, response, body) -> () in
        //            if (error != nil) {
        //                print("=======error======")
        //                print(error)
        //                return
        //            }
        //            print(body as! String)
        //        })
        //        print("hogehoge")
    }
    
    
    func capabilityTokenValid() -> Bool {
        var isValid:Bool = false
        
        if (self.device != nil) {
            let capabilityies = self.device!.capabilities! as NSDictionary
            
            let expirationTimeObject:NSNumber = capabilityies.objectForKey("expiration") as! NSNumber
            let expirationTimeValue:Int64 = expirationTimeObject.longLongValue
            let currentTimeValue:NSTimeInterval = NSDate().timeIntervalSince1970
            
            if ( (expirationTimeValue-Int64(currentTimeValue)) > 0 ) {
                isValid = true
            }
        }
        
        return isValid
    }
    
}
