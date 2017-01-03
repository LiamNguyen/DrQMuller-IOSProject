//
//  PMHandleBooking.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /30/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import UIKit

class PMHandleBooking: NSObject, HTTPClientDelegate {
    private var httpClient: HTTPClient!
    private var counter = 1
    
    override init() {
        super.init()
        httpClient = HTTPClient()
        httpClient.delegate = self
    }
    
    //=========LISTEN TO RESPONSE FROM GET REQUEST=========
    
    func onReceiveRequestResponse(data: AnyObject) {
//HANDLE COUNTRIES DATASOURCE
        var dropDownCountriesDataSource = [String]()
        if let arrayDataSource = data["Select_Countries"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownCountriesDataSource.append(dictItem["COUNTRY"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownCountriesDataSource = dropDownCountriesDataSource
        }
//HANDLE CITIES DATASOURCE
        var dropDownCitiesDataSource = [String]()
        if let arrayDataSource = data["Select_Cities"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownCitiesDataSource.append(dictItem["CITY"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownCitiesDataSource = dropDownCitiesDataSource
        }
//HANDLE DISTRICTS DATASOURCE
        var dropDownDistrictsDataSource = [String]()
        if let arrayDataSource = data["Select_Districts"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownDistrictsDataSource.append(dictItem["DISTRICT"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownDistrictsDataSource = dropDownDistrictsDataSource
        }
//HANDLE LOCATIONS DATASOURCE
        var dropDownLocationsDataSource = [String]()
        if let arrayDataSource = data["Select_Locations"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownLocationsDataSource.append(dictItem["ADDRESS"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownLocationsDataSource = dropDownLocationsDataSource
        }
//HANDLE VOUCHERS DATASOURCE
        var dropDownVouchersDataSource = [String]()
        if let arrayDataSource = data["Select_Vouchers"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownVouchersDataSource.append(dictItem["VOUCHER"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownVouchersDataSource = dropDownVouchersDataSource
        }
//HANDLE TYPES DATASOURCE
        var dropDownTypesDataSource = [String]()
        if let arrayDataSource = data["Select_Types"]! as? NSArray {
            for arrayItem in arrayDataSource {
                let dictItem = arrayItem as! NSDictionary
                dropDownTypesDataSource.append(dictItem["TYPE"]! as! String)
            }
            DTOStaticArrayDataSource.sharedInstance.dropDownTypesDataSource = dropDownTypesDataSource
        }
        
        if self.counter == 6 {
            var returnArrayDataSource = [String: DTOStaticArrayDataSource]()
            returnArrayDataSource["returnArrayDataSource"] = DTOStaticArrayDataSource.sharedInstance
            NotificationCenter.default.post(name: Notification.Name(rawValue: "arrayDataSource"), object: nil, userInfo: returnArrayDataSource)
            pushToUserDefaults(arrayDataSourceObj: DTOStaticArrayDataSource.sharedInstance)
            
            counter = 1
        }
        counter += 1
    }

    func getDropDownsDataSource() {
        let pulledDtoArrays = pullFromUserDefaults()
        
        if pulledDtoArrays != nil {
            var returnArrayDataSourceOffline = [String: DTOStaticArrayDataSource]()
            returnArrayDataSourceOffline["returnArrayDataSourceOffline"] = pulledDtoArrays
            NotificationCenter.default.post(name: Notification.Name(rawValue: "arrayDataSourceOffline"), object: nil, userInfo: returnArrayDataSourceOffline)
            return
        }
        
        httpClient.getRequest(url: "Select_Countries", parameter: "")
        httpClient.getRequest(url: "Select_Cities", parameter: "?country_id=235")
        httpClient.getRequest(url: "Select_Districts", parameter: "?city_id=58")
        httpClient.getRequest(url: "Select_Locations", parameter: "?district_id=630")
        httpClient.getRequest(url: "Select_Vouchers", parameter: "")
        httpClient.getRequest(url: "Select_Types", parameter: "")
    }
    
    private func pushToUserDefaults(arrayDataSourceObj: DTOStaticArrayDataSource) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: arrayDataSourceObj)
        userDefaults.set(encodedData, forKey: "arrayDataSourceOffline")
        if userDefaults.synchronize() {
            print("Array DataSource Stored")
        }
    }
    
    private func pullFromUserDefaults() -> DTOStaticArrayDataSource? {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "arrayDataSourceOffline") == nil {
            return nil
        }
        
        let decodedData = userDefaults.object(forKey: "arrayDataSourceOffline") as! Data
        let pulledDtoArrays = NSKeyedUnarchiver.unarchiveObject(with: decodedData) as! DTOStaticArrayDataSource
        return pulledDtoArrays
    }

    
}
