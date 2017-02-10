//
//  SecondTabCustomerInformationViewController.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /20/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import UIKit

class SecondTabCustomerInformationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, SlideButtonDelegate {

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
    @IBOutlet private weak var picker_Gender: UIPickerView!
    @IBOutlet private weak var picker_Date: UIDatePicker!
    @IBOutlet private weak var slideBtn_Next: MMSlidingButton!
    @IBOutlet private weak var lbl_Title: UILabel!
    
    private var customerInformationController = CustomStyleCustomerInformation()
    private var picker_GenderDataSource = [String]()
    private let datePickerRange = DatePickerRange()
    private var networkViewManager = NetworkViewManager()
    private var networkCheckInRealTime: Timer!
    
    private var modelHandelCustomerInformation = ModelHandleCustomerInformation()
    
    private func updateUI() {
        lbl_Title.text = "CUSTOMER_INFO_PAGE_TITLE".localized()
        btn_FirstTab.setTitle("FIRST_TAB_BTN_TITLE".localized(), for: .normal)
        btn_SecondTab.setTitle("SECOND_TAB_BTN_TITLE".localized(), for: .normal)
        btn_ThirdTab.setTitle("THIRD_TAB_BTN_TITLE".localized(), for: .normal)
        
        picker_GenderDataSource = ["GENDER_MALE".localized(), "GENDER_FEMALE".localized()]
        
        picker_Date.locale = NSLocale.init(localeIdentifier: Functionality.getDatePickerLocale(language: UserDefaults.standard.string(forKey: "lang") ?? "vi")) as Locale
        
        self.slideBtn_Next.buttonText = "BTN_NEXT_TITLE".localized()
        
        self.slideBtn_Next.buttonUnlockedText = "SLIDE_BTN_UNLOCKED_TITLE".localized()
    }
    
    private struct StoryBoard {
        static let SEGUE_TO_LOGIN = "segue_CustomerInformationSecondTabToLogin"
        static let SEGUE_TO_FIRST_TAB = "segue_CustomerInformationSecondTabToFirstTab"
        static let SEGUE_TO_THIRD_TAB = "segue_CustomerInformationSecondTabToThirdTab"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//=========DATE PICKER SET MAX=========

        datePickerRange.datePickerConstraintMax(MaxRangeFromCurrentDate: -13, DatePicker: self.picker_Date)
        
//=========ENABLE TAB HEADERS=========
        
        customerInformationController.enableTab(firstTab: btn_FirstTab, secondTab: btn_SecondTab, thirdTab: btn_ThirdTab)
        
//=========UPDATE STYLE OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========
        
        customerInformationController.tabHeadersStyleUpdate(FirstTabConstraint: constraint_FirstTabWidth,SecondTabConstraint: constraint_SecondTabWidth, ThirdTabConstraint: constraint_ThirdTabWidth)
        
//=========UPDATE ORIGIN OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========
        
        customerInformationController.tabHeadersOriginUpdate(view_FirstTabContainer: view_FirstTabContainer,view_SecondTabContainer: view_SecondTabContainer, view_ThirdTabContainer: view_ThirdTabContainer)
        
//=========APPLY TAB HEADERS UNDERLINE=========
        
        customerInformationController.translateTabHeaderUnderline(view: self.view, view_TabContainer: view_SecondTabContainer)
        
//=========DELEGATING VIEW PICKER=========
        
        self.picker_Gender.dataSource = self
        self.picker_Gender.delegate = self

        
//=========DELEGATING slideBtn_Next=========
        
        self.slideBtn_Next.delegate = self
        self.slideBtn_Next.reset()
        
        let tupleDetectNetworkReachabilityResult = Reachability.detectNetworkReachabilityObserver(parentView: self.view)
        networkViewManager = tupleDetectNetworkReachabilityResult.network
        networkCheckInRealTime = tupleDetectNetworkReachabilityResult.timer
        
//=========OBSERVING NOTIFICATION FROM PMHandleCustomerInformation=========
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "necessaryInfoResponse"), object: nil)
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "necessaryInfoResponse"), object: nil, queue: nil) { (Notification) in
            if let userInfo = Notification.userInfo {
                if let isSuccess = userInfo["status"] as? Bool {
                    if isSuccess {
                        DispatchQueue.global(qos: .userInteractive).async {
                            DTOCustomerInformation.sharedInstance.customerInformationDictionary["step"] = "necessary"
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: StoryBoard.SEGUE_TO_THIRD_TAB, sender: self)
                            }
                        }
                    } else {
                        ToastManager.alert(view: self.view_TopView, msg: "UPDATE_FAIL_MESSAGE".localized())
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        networkCheckInRealTime.invalidate()
    }
    
    @IBAction func btn_Back_OnClick(_ sender: Any) {
        
//=========POP UP CONFIRM DIALOG=========
        
        DialogManager.confirmLogout(sender: self, segueIdentifier: StoryBoard.SEGUE_TO_LOGIN)
    }
    
//=========TRANSITION TO FIRST INFO PAGE=========
    
    @IBAction func btn_FirstTab_OnClick(_ sender: Any) {
        self.performSegue(withIdentifier: StoryBoard.SEGUE_TO_FIRST_TAB, sender: self)
    }
    
    
//=========TRANSITION TO THIRD INFO PAGE=========

    @IBAction func btn_ThirdTab_OnClick(_ sender: Any) {
        self.performSegue(withIdentifier: StoryBoard.SEGUE_TO_THIRD_TAB, sender: self)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker_GenderDataSource.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker_GenderDataSource[row]
    }
    
//=========TRANSITION TO THIRD INFO PAGE WITH slideBtn_Next=========
    
    func buttonStatus(_ status:String, sender:MMSlidingButton) {
        let step = "necessary"
        
        DTOCustomerInformation.sharedInstance.customerInformationDictionary["userDob"] = picker_Date.date.shortDate
        DTOCustomerInformation.sharedInstance.customerInformationDictionary["userGender"] = picker_GenderDataSource[picker_Gender.selectedRow(inComponent: 0)]
        
        modelHandelCustomerInformation.handleCustomerInformation(step: step, httpBody: DTOCustomerInformation.sharedInstance.returnHttpBody(step: step)!)
        
        self.performSegue(withIdentifier: StoryBoard.SEGUE_TO_THIRD_TAB, sender: self)
    }
    
//=========TOUCH OUTSIDE CLOSE KEYBOARD=========
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
//=========PRESS RETURN CLOSE KEYBOARD=========
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    
    
    
}
