//
//  ServiceURL.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /26/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import Foundation

public class ServiceURL {
    
    private var environment: Environments
    private var prdURL = [String:String]()
    private var betaURL = [String: String]()
    private var uatURL = [String:String]()
    private var localURL = [String:String]()
    
    init (environment: Environments) {
        self.environment = environment
//===============IF THIS IS PRODUCTION ENVIRONMENTS================
        switch environment {
        case .PRD:
            prdURL["Select_ToAuthenticate"] = "http://210.211.109.180/drmuller/Select_ToAuthenticate.php"
            prdURL["Select_CheckUserExistence"] = "http://210.211.109.180/drmuller/Select_CheckUserExistence.php"
            prdURL["Select_NumberOfCustomer"] = "http://210.211.109.180/drmuller/Select_NumberOfCustomer.php"
            prdURL["Select_Countries"] = "http://210.211.109.180/drmuller/Select_Countries.php"
            prdURL["Select_Cities"] = "http://210.211.109.180/drmuller/Select_Cities.php"
            prdURL["Select_Districts"] = "http://210.211.109.180/drmuller/Select_Districts.php"
            prdURL["Select_Locations"] = "http://210.211.109.180/drmuller/Select_Locations.php"
            prdURL["Select_Vouchers"] = "http://210.211.109.180/drmuller/Select_Vouchers.php"
            prdURL["Select_Types"] = "http://210.211.109.180/drmuller/Select_Types.php"
            prdURL["Select_AllTime"] = "http://210.211.109.180/drmuller/Select_AllTime.php"
            prdURL["Select_EcoTime"] = "http://210.211.109.180/drmuller/Select_EcoTime.php"
            prdURL["Select_DaysOfWeek"] = "http://210.211.109.180/drmuller/Select_DaysOfWeek.php"
            prdURL["Select_SelectedTime"] = "http://210.211.109.180/drmuller/Select_SelectedTime.php"
            prdURL["Select_Machines"] = "http://210.211.109.180/drmuller/Select_Machines.php"
            prdURL["Insert_NewCustomer"] = "http://210.211.109.180/drmuller/Insert_NewCustomer.php"
            prdURL["Insert_NewAppointment"] = "http://210.211.109.180/drmuller/Insert_NewAppointment.php"
            prdURL["Insert_NewBookingTime"] = "http://210.211.109.180/drmuller/Insert_NewBookingTime.php"
            prdURL["Update_UnchosenTime"] = "http://210.211.109.180/drmuller/Update_UnchosenTime.php"
            prdURL["Update_CustomerInfo"] = "http://210.211.109.180/drmuller/Update_CustomerInfo.php"
            prdURL["Update_ValidateAppointment"] = "http://210.211.109.180/drmuller/Update_ValidateAppointment.php"
            prdURL["Update_Appointment"] = "http://210.211.109.180/drmuller/Update_Appointment.php"
            prdURL["Update_CancelAppointment"] = "http://210.211.109.180/drmuller/Update_CancelAppointment.php"
            prdURL["Update_VerifyAcc"] = "http://210.211.109.180/drmuller/Update_VerifyAcc.php"
            prdURL["Update_ResetPw"] = "http://210.211.109.180/drmuller/Update_ResetPw.php"
            prdURL["SendMail_VerifyAcc"] = "http://210.211.109.180/drmuller/SendMail_VerifyAcc.php"
            prdURL["SendMail_ResetPassword"] = "http://210.211.109.180/drmuller/SendMail_ResetPassword.php"
            prdURL["BookingTransaction"] = "http://210.211.109.180/drmuller/BookingTransaction.php"
            prdURL["Update_BasicInfo"] = "http://210.211.109.180/drmuller/Update_BasicInfo.php"
            prdURL["Update_NecessaryInfo"] = "http://210.211.109.180/drmuller/Update_NecessaryInfo.php"
            prdURL["Update_ImportantInfo"] = "http://210.211.109.180/drmuller/Update_ImportantInfo.php"
        case .BETA:
            betaURL["Select_ToAuthenticate"] = "http://210.211.109.180/drmuller_test/Select_ToAuthenticate.php"
            betaURL["Select_CheckUserExistence"] = "http://210.211.109.180/drmuller_test/Select_CheckUserExistence.php"
            betaURL["Select_NumberOfCustomer"] = "http://210.211.109.180/drmuller_test/Select_NumberOfCustomer.php"
            betaURL["Select_Countries"] = "http://210.211.109.180/drmuller_test/Select_Countries.php"
            betaURL["Select_Cities"] = "http://210.211.109.180/drmuller_test/Select_Cities.php"
            betaURL["Select_Districts"] = "http://210.211.109.180/drmuller_test/Select_Districts.php"
            betaURL["Select_Locations"] = "http://210.211.109.180/drmuller_test/Select_Locations.php"
            betaURL["Select_Vouchers"] = "http://210.211.109.180/drmuller_test/Select_Vouchers.php"
            betaURL["Select_Types"] = "http://210.211.109.180/drmuller_test/Select_Types.php"
            betaURL["Select_AllTime"] = "http://210.211.109.180/drmuller_test/Select_AllTime.php"
            betaURL["Select_EcoTime"] = "http://210.211.109.180/drmuller_test/Select_EcoTime.php"
            betaURL["Select_DaysOfWeek"] = "http://210.211.109.180/drmuller_test/Select_DaysOfWeek.php"
            betaURL["Select_SelectedTime"] = "http://210.211.109.180/drmuller_test/Select_SelectedTime.php"
            betaURL["Select_Machines"] = "http://210.211.109.180/drmuller_test/Select_Machines.php"
            betaURL["Insert_NewCustomer"] = "http://210.211.109.180/drmuller_test/Insert_NewCustomer.php"
            betaURL["Insert_NewAppointment"] = "http://210.211.109.180/drmuller_test/Insert_NewAppointment.php"
            betaURL["Insert_NewBookingTime"] = "http://210.211.109.180/drmuller_test/Insert_NewBookingTime.php"
            betaURL["Update_UnchosenTime"] = "http://210.211.109.180/drmuller_test/Update_UnchosenTime.php"
            betaURL["Update_CustomerInfo"] = "http://210.211.109.180/drmuller_test/Update_CustomerInfo.php"
            betaURL["Update_ValidateAppointment"] = "http://210.211.109.180/drmuller_test/Update_ValidateAppointment.php"
            betaURL["Update_Appointment"] = "http://210.211.109.180/drmuller_test/Update_Appointment.php"
            betaURL["Update_CancelAppointment"] = "http://210.211.109.180/drmuller_test/Update_CancelAppointment.php"
            betaURL["Update_VerifyAcc"] = "http://210.211.109.180/drmuller_test/Update_VerifyAcc.php"
            betaURL["Update_ResetPw"] = "http://210.211.109.180/drmuller_test/Update_ResetPw.php"
            betaURL["SendMail_VerifyAcc"] = "http://210.211.109.180/drmuller_test/SendMail_VerifyAcc.php"
            betaURL["SendMail_ResetPassword"] = "http://210.211.109.180/drmuller_test/SendMail_ResetPassword.php"
            betaURL["BookingTransaction"] = "http://210.211.109.180/drmuller_test/BookingTransaction.php"
            betaURL["Update_BasicInfo"] = "http://210.211.109.180/drmuller_test/Update_BasicInfo.php"
            betaURL["Update_NecessaryInfo"] = "http://210.211.109.180/drmuller_test/Update_NecessaryInfo.php"
            betaURL["Update_ImportantInfo"] = "http://210.211.109.180/drmuller_test/Update_ImportantInfo.php"

        case .LOCAL:
//===============IF THIS IS LOCAL ENVIRONMENTS================
            localURL["Select_ToAuthenticate"] = "http://localhost/drmuller/Select_ToAuthenticate.php"
            localURL["Select_CheckUserExistence"] = "http://localhost/drmuller/Select_CheckUserExistence.php"
            localURL["Select_NumberOfCustomer"] = "http://localhost/drmuller/Select_NumberOfCustomer.php"
            localURL["Select_Countries"] = "http://localhost/drmuller/Select_Countries.php"
            localURL["Select_Cities"] = "http://localhost/drmuller/Select_Cities.php"
            localURL["Select_Districts"] = "http://localhost/drmuller/Select_Districts.php"
            localURL["Select_Locations"] = "http://localhost/drmuller/Select_Locations.php"
            localURL["Select_Vouchers"] = "http://localhost/drmuller/Select_Vouchers.php"
            localURL["Select_Types"] = "http://localhost/drmuller/Select_Types.php"
            localURL["Select_AllTime"] = "http://localhost/drmuller/Select_AllTime.php"
            localURL["Select_EcoTime"] = "http://localhost/drmuller/Select_EcoTime.php"
            localURL["Select_DaysOfWeek"] = "http://localhost/drmuller/Select_DaysOfWeek.php"
            localURL["Select_SelectedTime"] = "http://localhost/drmuller/Select_SelectedTime.php"
            localURL["Select_Machines"] = "http://localhost/drmuller/Select_Machines.php"
            localURL["Insert_NewCustomer"] = "http://localhost/drmuller/Insert_NewCustomer.php"
            localURL["Insert_NewAppointment"] = "http://localhost/drmuller/Insert_NewAppointment.php"
            localURL["Insert_NewBookingTime"] = "http://localhost/drmuller/Insert_NewBookingTime.php"
            localURL["Update_UnchosenTime"] = "http://localhost/drmuller/Update_UnchosenTime.php"
            localURL["Update_CustomerInfo"] = "http://localhost/drmuller/Update_CustomerInfo.php"
            localURL["Update_ValidateAppointment"] = "http://localhost/drmuller/Update_ValidateAppointment.php"
            localURL["Update_Appointment"] = "http://localhost/drmuller/Update_Appointment.php"
            localURL["Update_CancelAppointment"] = "http://localhost/drmuller/Update_CancelAppointment.php"
            localURL["Update_VerifyAcc"] = "http://localhost/drmuller/Update_VerifyAcc.php"
            localURL["Update_ResetPw"] = "http://localhost/drmuller/Update_ResetPw.php"
            localURL["SendMail_VerifyAcc"] = "http://localhost/drmuller/SendMail_VerifyAcc.php"
            localURL["SendMail_ResetPassword"] = "http://localhost/drmuller/SendMail_ResetPassword.php"
            localURL["BookingTransaction"] = "http://localhost/drmuller/BookingTransaction.php"
            localURL["Update_BasicInfo"] = "http://localhost/drmuller/Update_BasicInfo.php"
            localURL["Update_NecessaryInfo"] = "http://localhost/drmuller/Update_NecessaryInfo.php"
            localURL["Update_ImportantInfo"] = "http://localhost/drmuller/Update_ImportantInfo.php"
//===============IF THIS IS UAT ENVIRONMENTS================
        default:
            uatURL["Select_ToAuthenticate"] = "http://drqmuller.com/drmuller/Select_ToAuthenticate.php"
            uatURL["Select_CheckUserExistence"] = "http://drqmuller.com/drmuller/Select_CheckUserExistence.php"
            uatURL["Select_NumberOfCustomer.php"] = "http://drqmuller.com/drmuller/Select_NumberOfCustomer.php"
            uatURL["Select_Countries"] = "http://drqmuller.com/drmuller/Select_Countries.php"
            uatURL["Select_Cities"] = "http://drqmuller.com/drmuller/Select_Cities.php"
            uatURL["Select_Districts"] = "http://drqmuller.com/drmuller/Select_Districts.php"
            uatURL["Select_Locations"] = "http://drqmuller.com/drmuller/Select_Locations.php"
            uatURL["Select_Vouchers"] = "http://drqmuller.com/drmuller/Select_Vouchers.php"
            uatURL["Select_Types"] = "http://drqmuller.com/drmuller/Select_Types.php"
            uatURL["Select_AllTime"] = "http://drqmuller.com/drmuller/Select_AllTime.php"
            uatURL["Select_EcoTime"] = "http://drqmuller.com/drmuller/Select_EcoTime.php"
            uatURL["Select_DaysOfWeek"] = "http://drqmuller.com/drmuller/Select_DaysOfWeek.php"
            uatURL["Select_SelectedTime"] = "http://drqmuller.com/drmuller/Select_SelectedTime.php"
            uatURL["Select_Machines"] = "http://drqmuller.com/drmuller/Select_Machines.php"
            uatURL["Insert_NewCustomer"] = "http://drqmuller.com/drmuller/Insert_NewCustomer.php"
            uatURL["Insert_NewAppointment"] = "http://drqmuller.com/drmuller/Insert_NewAppointment.php"
            uatURL["Insert_NewBookingTime"] = "http://drqmuller.com/drmuller/Insert_NewBookingTime.php"
            uatURL["Update_UnchosenTime"] = "http://drqmuller.com/drmuller/Update_UnchosenTime.php"
            uatURL["Update_CustomerInfo"] = "http://drqmuller.com/drmuller/Update_CustomerInfo.php"
            uatURL["Update_ValidateAppointment"] = "http://drqmuller.com/drmuller/Update_ValidateAppointment.php"
            uatURL["Update_Appointment"] = "http://drqmuller.com/drmuller/Update_Appointment.php"
            uatURL["Update_CancelAppointment"] = "http://drqmuller.com/drmuller/Update_CancelAppointment.php"
            uatURL["Update_VerifyAcc"] = "http://drqmuller.com/drmuller/Update_VerifyAcc.php"
            uatURL["Update_ResetPw"] = "http://drqmuller.com/drmuller/Update_ResetPw.php"
            uatURL["SendMail_VerifyAcc"] = "http://drqmuller.com/drmuller/SendMail_VerifyAcc.php"
            uatURL["SendMail_ResetPassword"] = "http://drqmuller.com/drmuller/SendMail_ResetPassword.php"
            uatURL["BookingTransaction"] = "http://drqmuller.com/drmuller/BookingTransaction.php"
            uatURL["Update_BasicInfo"] = "http://drqmuller.com/drmuller/Update_BasicInfo.php"
            uatURL["Update_NecessaryInfo"] = "http://drqmuller.com/drmuller/Update_NecessaryInfo.php"
            uatURL["Update_ImportantInfo"] = "http://drqmuller.com/drmuller/Update_ImportantInfo.php"
        }
    }
    
    func getServiceURL(serviceURL: String) -> String {
        switch self.environment {
        case .PRD:
            if let url = prdURL[serviceURL] {
                return url
            } else {
                return "Can't find URL"
            }
        case .BETA:
            if let url = betaURL[serviceURL] {
                return url
            } else {
                return "Can't find URL"
            }
        case .LOCAL:
            if let url = localURL[serviceURL] {
                return url
            } else {
                return "Can't find URL"
            }
        default:
            if let url = uatURL[serviceURL] {
                return url
            } else {
                return "Can't find URL"
            }
        }
    }
    
    enum Environments {
        case PRD
        case UAT
        case LOCAL
        case BETA
    }
}
