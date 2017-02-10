//
//  PMHandleLogin.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /26/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import UIKit

class PMHandleLogin: NSObject, HTTPClientDelegate {
    
    var httpClient: HTTPClient!
    
    override init() {
        super.init()
        httpClient = HTTPClient()
        httpClient.delegate = self
    }
    
    func handleLogin(username: String, password: String) {
        DTOAuthentication.sharedInstance.username = username
        DTOAuthentication.sharedInstance.password = password
        
        if let postStr = DTOAuthentication.sharedInstance.returnHttpBody() {
            httpClient.postRequest(url: "Select_ToAuthenticate", body: postStr)
        } else {
            print("Missing body parameters")
        }
    }
    
    func onReceiveRequestResponse(data: AnyObject) {
        var isOk = [String: Bool]()
        if let arrayResponse = data["Select_ToAuthenticate"] as? NSArray {
            for arrayItem in arrayResponse {
                let arrayDict = arrayItem as? NSDictionary
                
                if let token = arrayDict?["jwt"] as? String {
                    UserDefaults.standard.set(token, forKey: "CustomerInformation")
                    DTOCustomerInformation.sharedInstance.customerInformationDictionary = Functionality.jwtDictionarify(token: token)
                }
                
                if let result = arrayDict?["Status"] as? String {
                    if result == "1" {
                        isOk["status"] = true
                    } else {
                        isOk["status"] = false
                    }
                }
            }
        }
        DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginResponse"), object: nil, userInfo: isOk)
        }
    }
}
