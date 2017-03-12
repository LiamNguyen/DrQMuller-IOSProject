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
    
    func onReceiveRequestResponse(data: AnyObject) {}
    
    func onReceivePostRequestResponse(data: AnyObject, statusCode: Int) {
        var dataToSend = [String: Any]()
        
        dataToSend["statusCode"] = statusCode
        dataToSend["errorCode"] = ""
        
//        Status code 500
        if statusCode == HttpStatusCode.internalServerError {
            dataToSend["errorCode"] = Error.Backend.serverError
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginResponse"), object: nil, userInfo: dataToSend)
            }
            return
        }
        
        if let response = data["Select_ToAuthenticate"] as? NSArray {
            for item in response {
                let responseObj = item as? NSDictionary
                
//                Status code 400
                if statusCode == HttpStatusCode.badRequest {
                    dataToSend["errorCode"] = responseObj?["errorCode"] as? String
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginResponse"), object: nil, userInfo: dataToSend)
                    }
                    return
                }
                
//                Status code 401
                if statusCode == HttpStatusCode.unauthorized {
                    dataToSend["errorCode"] = responseObj?["errorCode"] as? String
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginResponse"), object: nil, userInfo: dataToSend)
                    }
                    return
                }
                
                if statusCode == HttpStatusCode.success {
                    if let jwt = responseObj?["jwt"] as? String {
                        UserDefaults.standard.set(jwt, forKey: UserDefaultKeys.customerInformation)
                        DTOCustomerInformation.sharedInstance.customerInformationDictionary = Functionality.jwtDictionarify(token: jwt)                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginResponse"), object: nil, userInfo: dataToSend)
                        }

                    } else {
                        print("Error while getting JWT")
                    }
                }
                
            }
        }
    }
}
