//
//  LoginViewController.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /26/11/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, HTTPClientDelegate {

    @IBOutlet private weak var loginView: UIView!
    @IBOutlet private weak var txtView: UIView!
    @IBOutlet private weak var txt_Username: CustomTxtField!
    @IBOutlet private weak var txt_Password: CustomTxtField!
    @IBOutlet private weak var btn_ResetPassword: UIButton!
    @IBOutlet private weak var btn_Login: UIButton!
    @IBOutlet private weak var btn_Register: UIButton!
    @IBOutlet private weak var constraint_BtnLogin_TxtConfirm: NSLayoutConstraint!
    
    private var initialViewOrigin: CGFloat!
    private var initialTxtOrigin: CGFloat!
    private var screenHeight: CGFloat!
    private var isIphone4 = false
    private var initialConstraintConstant: CGFloat!
    private var lineDrawer = LineDrawer()
    var testReturnArr = HTTPClient()
    private var modelHandleLogin = ModelHandleLogin()
    private var message = Messages()
    
    func onReceiveRequestResponse(data: AnyObject) {
        if let array = data["Select_Vouchers"]! as? NSArray {
            let dict = array[1] as! NSDictionary
            print(dict["VOUCHER"]!)
        } else if let array = data["Select_AllTime"]! as? NSArray {
            print(array)
        } else {
            print("Wrongggg")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testReturnArr.delegate = self

        
//=========TXTFIELD DELEGATE=========
        
        self.txt_Username.delegate = self
        self.txt_Password.delegate = self
        
//=========STYLE FOR RESET PASSWORD LINK=========
        
        let attrString = NSAttributedString(string: "Quên mật khẩu hoặc tên đăng nhập?", attributes: [NSForegroundColorAttributeName:UIColor.white, NSUnderlineStyleAttributeName: 1])
        
        btn_ResetPassword.setAttributedTitle(attrString, for: .normal)
        
//=========STYLE BUTTONS=========
        
        btn_Login.layer.cornerRadius = 10
        btn_Register.layer.cornerRadius = 10
        
//=========ASSIGN ORIGIN X SUBVIEW=========
        
        initialViewOrigin = loginView.frame.origin.y
        
//=========ASSIGN ORIGIN X VIEW CONTAINS TEXT FIELDS=========
        
        initialTxtOrigin = txtView.frame.origin.y
        
//=========ASSIGN CONSTANT CONSTRAINTS BTN_LOGIN_TXT_CONFIRM=========

        initialConstraintConstant = constraint_BtnLogin_TxtConfirm.constant
        
//=========GET SCREEN SIZE=========
        
        screenHeight = UIScreen.main.bounds.height
        
//=========ASSIGN BOOLEAN VARIABLE FOR ISIPHONE4=========
        
        if screenHeight == 480 {
            isIphone4 = true
        }
        
//=========UPDATE FOR IPHONE 4S SCREEN ON LOAD=========
        
        updateLoadStyleForIphone4()
        
//        //=========DRAW LINE=========
//
//        let firstPoint = CGPoint(x: 0, y: 480)
//        let secondPoint = CGPoint(x: UIScreen.main.bounds.width, y: 480)
//        
//        lineDrawer.addLine(fromPoint: firstPoint, toPoint: secondPoint, lineWidth: 2, color: UIColor(netHex: 0x8F00B3), view: self.view)
//        
//        let thirdPoint = CGPoint(x: 0, y: 480 - 216)
//        let fourthPoint = CGPoint(x: UIScreen.main.bounds.width, y: 480 - 216)
//        
//        lineDrawer.addLine(fromPoint: thirdPoint, toPoint: fourthPoint, lineWidth: 2, color: UIColor.red, view: self.view)
        
//=========TOAST SET UP COLOR=========
        
        UIView.hr_setToastThemeColor(color: ToastColorAlert)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//=========TEXT FIELD FOCUS CALL BACK FUNCTION=========
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isIphone4 {
            adjustViewOrigin(y: 20)
            return
        }
        updateTxtFieldFocusStyleForIphone4()
    }
    
//=========OUTSIDE TOUCH CLOSE KEYBOARD=========
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        if !isIphone4 {
            adjustViewOrigin(y: initialViewOrigin)
            return
        }
        updateTxtFieldLoseFocusStyleForIphone4()
    }
    
//=========PRESS RETURN CLOSE KEYBOARD=========
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if textField == txt_Username {
            txt_Password.becomeFirstResponder()
        }
        
        if !isIphone4 && textField == txt_Password {
            adjustViewOrigin(y: initialViewOrigin)
            login()
            return true
        }

        if textField != txt_Password {
            return true
        }
        updateTxtFieldLoseFocusStyleForIphone4()
        return true
    }
    
//=========ADJUST VIEW ORIGIN Y=========
    
    private func adjustViewOrigin(y: CGFloat) {
        loginView.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.loginView.frame.origin = CGPoint(x: self.loginView.frame.origin.x, y: y)
        }
    }
    
//=========ADJUST VIEW CONTAIN TEXT FIELDS ORIGIN Y=========
    
    private func adjustTxtOrigin(y: CGFloat) {
        txtView.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.txtView.frame.origin = CGPoint(x: self.txtView.frame.origin.x, y: y)
        }
    }

//=========ADJUST LOGIN BUTTON ORIGIN Y=========
    
    private func adjustBtnOrigin(y: CGFloat) {
        btn_Login.translatesAutoresizingMaskIntoConstraints = true
        UIView.animate(withDuration: 0.4) { () -> Void in
            self.btn_Login.frame.origin = CGPoint(x: self.btn_Login.frame.origin.x, y: y)
        }
    }
    
//=========UPDATE UI FOR IPHONE 4S ON LOAD=========

    private func updateLoadStyleForIphone4() {
        if !isIphone4 {
            return
        }
        adjustViewOrigin(y: 10)
    }
    
//=========UPDATE UI FOR IPHONE 4 WHEN ON TXTFIELD FOCUS=========
    
    private func updateTxtFieldFocusStyleForIphone4() {
        adjustTxtOrigin(y: 60)
        constraint_BtnLogin_TxtConfirm.constant = 20
        btn_ResetPassword.isHidden = true
    }
    
//=========REVERT UPDATE UI FOR IPHONE 4 ON TXTFIELD LOSE FOCUS=========

    private func updateTxtFieldLoseFocusStyleForIphone4() {
        adjustTxtOrigin(y: initialTxtOrigin)
        constraint_BtnLogin_TxtConfirm.constant = initialConstraintConstant
        btn_ResetPassword.isHidden = false
    }
    
    
    @IBAction func btn_Login_OnClick(_ sender: Any) {
        login()
    }
    
    private func login() {
        if !frontValidationPassed() {
            return
        }
        modelHandleLogin.handleLogin(username: txt_Username.text!, password: txt_Password.text!, viewController: self, toastView: loginView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segue_LoginToBookingTabViewController"){
            if let tabVC = segue.destination as? UITabBarController{
                tabVC.selectedIndex = 1
            }
        }
    }

    
//=========VALIDATE TEXTFIELD=========
    
    private func frontValidationPassed() -> Bool {
        if let username = txt_Username.text, let password = txt_Password.text {
            if username.isEmpty {
                ToastManager.sharedInstance.alert(view: loginView, msg: "Tên đăng nhập trống")
                return false
            }
            
            if password.isEmpty {
                ToastManager.sharedInstance.alert(view: loginView, msg: "Mật khẩu trống")
                return false
            }
            return true
        }
        return false
    }
    
    
}

