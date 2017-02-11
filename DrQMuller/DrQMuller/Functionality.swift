//
//  FunctionalityHelper.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /23/01/2017.
//  Copyright © 2017 LetsDev. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit
import JWTDecode

struct Functionality {
    
//CONVERT OBJ TO JSON STRING
    
    static func jsonStringify(obj: AnyObject) -> String {
        let jsonValidObj = JSONSerialization.isValidJSONObject(obj)
        if !jsonValidObj {
            return ""
        }
        
        let data = try! JSONSerialization.data(withJSONObject: obj, options: [])
        let jsonString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        
        return jsonString
    }
    
//CONVERT JSON TO DICTIONARY
    
    static func jsonDictionarify(json: String) -> NSDictionary {
        if let dictionaryFromJson = try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: .allowFragments) as? NSDictionary {
            return dictionaryFromJson
        } else {
            return [String: String]() as NSDictionary
        }
        
    }
    
//CONVERT JWT TO DICTIONARY
    
    static func jwtDictionarify(token: String) -> [String: Any] {
        do {
            let jwt = try decode(jwt: token)
            if let customerInformationDict = jwt.body["data"]! as? NSDictionary {
                return customerInformationDict as! [String: Any]
            } else {
                return [String: Any]()
            }
        } catch let error as NSError {
            print("Error message when decode JWT: \(error.localizedDescription)")
            return [String: Any]()
        }
    }
    
//SORT DICTIONARY KEYS OR VALUES AND RETURN ARRAY
    
    static func sortDictionary(dictionary: [String: String]) -> [String] {
        var sortedArr = [String]()
        
        for key in dictionary.values {
            let convertedKeyStr = key.replacingOccurrences(of: ":", with: "")
            let convertedKey = Int(convertedKeyStr)!
            if sortedArr.isEmpty {
                sortedArr.append(key)
                continue
            }
            for item in sortedArr {
                if convertedKey < Int(item.replacingOccurrences(of: ":", with: ""))! {
                    sortedArr.insert(key, at: sortedArr.index(of: item)!)
                    break
                }
                
                if sortedArr.index(of: item) == sortedArr.count - 1 {
                    sortedArr.insert(key, at: sortedArr.count)
                }
            }
        }
        
        return sortedArr
    }
    
//TRANSLATE DAYS OF WEEK
    
    static func translateDaysOfWeek(en: String) -> String {
        var daysOfWeek = ["Monday":"Thứ hai",
                          "Tuesday":"Thứ ba",
                          "Wednesday":"Thứ tư",
                          "Thursday":"Thứ năm",
                          "Friday":"Thứ sáu",
                          "Saturday":"Thứ bảy",
                          "Sunday":"Chủ nhật"]
        return daysOfWeek[en]!
    }
    
    static func translateGender(tranlate: String, to: language) -> String {
        var gender = ["Nam": "Male",
                      "Nữ": "Female"]
        var translated = ""
        
        if to == .VI {
            for item in gender {
                if item.value == tranlate {
                    translated = item.key
                }
            }
        } else {
            translated = gender[tranlate]!
        }
        
        return translated
    }
    
    enum language {
        case VI
        case EN
    }
    
//RETURN ARRAY FROM DICTIONARY

    static func returnArrayFromDictionary(dictionary: [String: String]!, isReturnValue: Bool) -> [String] {
        var resultArray = [String]()

        if let _ = dictionary {
            if isReturnValue {
                for values in dictionary.values {
                    resultArray.insert(values, at: resultArray.count)
                }
            } else {
                for keys in dictionary.keys {
                    resultArray.insert(keys, at: resultArray.count)
                }
            }
        }

        return resultArray
    }
    
//GET KEY FROM VALUE
    
    static func findKeyFromValue(dictionary: [String: String], value: String) -> String {
        var returnKey = String()
        
        for (dictKey, dictValue) in dictionary {
            if dictValue == value {
                returnKey = dictKey
                break
            }
        }
        
        return returnKey
    }
    
//=========PUSH STATIC ARRAY DATASOURCE TO USER DEFAULT==========
    
    static func pushToUserDefaults(arrayDataSourceObj: Any, forKey: String) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: arrayDataSourceObj)
        userDefaults.set(encodedData, forKey: forKey)
        if userDefaults.synchronize() {
            print("Array DataSource Stored")
        }
    }
    
//=========PULL STATIC ARRAY DATASOURCE TO USER DEFAULT==========
    
    static func pulledStaticArrayFromUserDefaults(forKey: String) -> Any? {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: forKey) == nil {
            return nil
        }
        
        let decodedData = userDefaults.object(forKey: forKey) as! Data
        let pulledDtoArrays = NSKeyedUnarchiver.unarchiveObject(with: decodedData)
        return pulledDtoArrays
    }
    
//CONVERT DATE FORMAT FROM A DATE TYPE OF STRING
    
    static func convertDateFormatFromStringToDate(str: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let formattedDate = dateFormatter.date(from: str)!
        return formattedDate
    }
   
//LOCALIZED DATE PICKER
    
    static func getDatePickerLocale(language: String) -> String {
        let date_picker_localization: String!
        
        if language == "en" {
            date_picker_localization = "en_EN"
        } else {
            date_picker_localization = "vi_VI"
        }
        
        return date_picker_localization
    }

//LOCALIZED TAB BAR ITEM
    
    static func tabBarItemsLocalized(language: String, tabVC: UITabBarController) {
        if language == "en" {
            tabVC.tabBar.items?[0].title = "News"
            tabVC.tabBar.items?[1].title = "Booking"
            tabVC.tabBar.items?[2].title = "User"
        }
    }
    
//GET CURRENT DATE TIME
    
    static func getCurrentDateTime() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:MM:ss"
        return "\(dateFormatter.string(from: date as Date))"
    }
    
//=========DRAW LINE TO ESTIMATE IPHONE 4 KEYBOARD=========
    
//    let firstPoint = CGPoint(x: 0, y: 480)
//    let secondPoint = CGPoint(x: UIScreen.main.bounds.width, y: 480)
//    
//    UIFunctionality.drawLine(fromPoint: firstPoint, toPoint: secondPoint, lineWidth: 2, color: UIColor.red, view: self.view)
//    
//    let thirdPoint = CGPoint(x: 0, y: 480 - 216)
//    let fourthPoint = CGPoint(x: UIScreen.main.bounds.width, y: 480 - 216)
//    
//    UIFunctionality.drawLine(fromPoint: thirdPoint, toPoint: fourthPoint, lineWidth: 2, color: UIColor.red, view: self.view)

}

