//
//  FirstTabCustomerInformationViewController.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /19/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import UIKit

class FirstTabCustomerInformationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var constraint_FirstTabWidth: NSLayoutConstraint!
    @IBOutlet private weak var constraint_SecondTabWidth: NSLayoutConstraint!
    @IBOutlet private weak var constraint_ThirdTabWidth: NSLayoutConstraint!
    @IBOutlet private weak var btn_FirstTab: UIButton!
    @IBOutlet private weak var btn_SecondTab: UIButton!
    @IBOutlet private weak var btn_ThirdTab: UIButton!
    @IBOutlet private weak var view_FirstTabContainer: UIView!
    @IBOutlet private weak var view_SecondTabContainer: UIView!
    @IBOutlet private weak var view_ThirdTabContainer: UIView!
    @IBOutlet private weak var view_TopView: UIView!
    @IBOutlet private weak var txt_Name: UITextField!
    @IBOutlet private weak var txt_Address: UITextField!
    @IBOutlet private weak var lbl_Title: UILabel!
    @IBOutlet private weak var btn_Next: UIButton!
    
    private var customerInformationController = CustomStyleCustomerInformation()
    private var networkViewManager = NetworkViewManager()
    private var networkCheckInRealTime: Timer!

    private func updateUI() {
        lbl_Title.text = "CUSTOMER_INFO_PAGE_TITLE".localized()
        btn_FirstTab.setTitle("FIRST_TAB_BTN_TITLE".localized(), for: .normal)
        btn_SecondTab.setTitle("SECOND_TAB_BTN_TITLE".localized(), for: .normal)
        btn_ThirdTab.setTitle("THIRD_TAB_BTN_TITLE".localized(), for: .normal)
        
        txt_Name.placeholder = "FULLNAME_PLACEHOLDER".localized()
        txt_Address.placeholder = "ADDRESS_PLACEHOLDER".localized()
        
        btn_Next.setTitle("BTN_NEXT_TITLE".localized(), for: .normal)
    }
    
    private struct Storyboard {
        static let SEGUE_TO_LOGIN = "segue_CustomerInformationToLogin"
        static let SEGUE_TO_SECOND_TAB = "segue_CustomerInformationFirstTabToSecondTab"
        static let SEGUE_TO_THIRD_TAB = "segue_CustomerInformationFirstTabToThirdTab"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//=========DELEGATING TEXTFIELD=========
        
        self.txt_Name.delegate = self
        self.txt_Address.delegate = self
        
//=========ENABLE TAB HEADERS=========

        customerInformationController.enableTab(firstTab: btn_FirstTab, secondTab: btn_SecondTab, thirdTab: btn_ThirdTab)
        
//=========UPDATE STYLE OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========

        customerInformationController.tabHeadersStyleUpdate(FirstTabConstraint: constraint_FirstTabWidth,SecondTabConstraint: constraint_SecondTabWidth, ThirdTabConstraint: constraint_ThirdTabWidth)
        
//=========UPDATE ORIGIN OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========

        customerInformationController.tabHeadersOriginUpdate(view_FirstTabContainer: view_FirstTabContainer,view_SecondTabContainer: view_SecondTabContainer, view_ThirdTabContainer: view_ThirdTabContainer)
        
//=========APPLY TAB HEADERS UNDERLINE=========

        customerInformationController.translateTabHeaderUnderline(view: self.view, view_TabContainer: view_FirstTabContainer)
        
//=========TEXTFIELD ONLOAD AUTOFOCUS=========

        txt_Name.becomeFirstResponder()
        
        let tupleDetectNetworkReachabilityResult = Reachability.detectNetworkReachabilityObserver(parentView: self.view)
        networkViewManager = tupleDetectNetworkReachabilityResult.network
        networkCheckInRealTime = tupleDetectNetworkReachabilityResult.timer
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        networkCheckInRealTime.invalidate()
    }
    
    @IBAction func btn_Back_OnClick(_ sender: Any) {
        
//=========POP UP CONFIRM DIALOG=========

        DialogManager.confirmLogout(sender: self, segueIdentifier: Storyboard.SEGUE_TO_LOGIN)
    }
    
//=========BUTTON NEXT ON CLICK=========

    @IBAction func btn_Next_OnClick(_ sender: Any) {
        if !frontValidationPassed() {
            return
        }
        DTOCustomerInformation.sharedInstance.customerInformationDictionary["name"] = txt_Name.text!
        DTOCustomerInformation.sharedInstance.customerInformationDictionary["address"] = txt_Address.text!
        self.performSegue(withIdentifier: Storyboard.SEGUE_TO_SECOND_TAB, sender: self)
    }
    
//=========TRANSITION TO SECOND INFO PAGE=========
    
    @IBAction func btn_SecondTab_OnClick(_ sender: Any) {
        self.performSegue(withIdentifier: Storyboard.SEGUE_TO_SECOND_TAB, sender: self)
    }
    
//=========TRANSITION TO THIRD INFO PAGE=========
    
    @IBAction func btn_ThirdTab_OnClick(_ sender: Any) {
        self.performSegue(withIdentifier: Storyboard.SEGUE_TO_THIRD_TAB, sender: self)
    }
    
//=========TOUCH OUTSIDE CLOSE KEYBOARD=========
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//=========PRESS RETURN CLOSE KEYBOARD=========
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txt_Name {
            txt_Address.becomeFirstResponder()
        }
        return true
    }
    
    private func frontValidationPassed() -> Bool {
        if let customerName = txt_Name.text, let address = txt_Address.text {
            if customerName.isEmpty {
                ToastManager.alert(view: view_TopView, msg: "CUSTOMER_NAME_EMPTY_MESSAGE".localized())
                return false
            }
            
            if address.isEmpty {
                ToastManager.alert(view: view_TopView, msg: "ADDRESS_EMPTY_MESSAGE".localized())
                return false
            }
            return true
        } else {
            return false
        }
    }
}
