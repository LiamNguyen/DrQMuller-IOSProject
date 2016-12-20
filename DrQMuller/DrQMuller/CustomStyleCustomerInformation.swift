//
//  CustomStyleCustomerInformation.swift
//  DrQMuller
//
//  Created by Cao Do Nguyen on /20/12/2016.
//  Copyright © 2016 LetsDev. All rights reserved.
//

import Foundation
import UIKit

class CustomStyleCustomerInformation: UIViewController {
    private var lineDrawer = LineDrawer()
    private var updatedWidth: CGFloat!
    
    //=========UPDATE STYLE OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========
    
    func tabHeadersStyleUpdate(FirstTabConstraint: NSLayoutConstraint, SecondTabConstraint: NSLayoutConstraint, ThirdTabConstraint: NSLayoutConstraint) {
        let screenWidth = Double(UIScreen.main.bounds.width)
        updatedWidth = CGFloat((screenWidth - 16) / 3)
        
        FirstTabConstraint.constant = updatedWidth
        SecondTabConstraint.constant = updatedWidth
        ThirdTabConstraint.constant = updatedWidth
    }
    
    //=========UPDATE ORIGIN OF TAB HEADERS FOR DIFFERENT PHONE SIZE=========
    
    func tabHeadersOriginUpdate(view_FirstTabContainer: UIView, view_SecondTabContainer: UIView, view_ThirdTabContainer: UIView) {
        let updatedOriginXSecondTab = updatedWidth + 8
        let updatedOriginXThirdTab = updatedWidth * 2 + 16

        view_FirstTabContainer.frame = CGRect(x: 0, y: view_FirstTabContainer.frame.origin.y, width: updatedWidth, height: view_SecondTabContainer.frame.size.height)
        view_SecondTabContainer.frame = CGRect(x: updatedOriginXSecondTab, y: view_SecondTabContainer.frame.origin.y, width: updatedWidth, height: view_SecondTabContainer.frame.size.height)
        view_ThirdTabContainer.frame = CGRect(x: updatedOriginXThirdTab, y: view_ThirdTabContainer.frame.origin.y, width: updatedWidth, height: view_ThirdTabContainer.frame.size.height)
    }
    
    //=========ENABLE TAB HEADERS BASE ON UIFILLSTEP=========
    
    func enableTab(firstTab: UIButton, secondTab: UIButton, thirdTab: UIButton) {
        let uiFillStep = 3
        
        switch uiFillStep {
        case 1:
            applyActiveStyle(button: firstTab)
        case 2:
            applyActiveStyle(button: firstTab)
            applyActiveStyle(button: secondTab)
        default:
            applyActiveStyle(button: firstTab)
            applyActiveStyle(button: secondTab)
            applyActiveStyle(button: thirdTab)
        }
    }
    
    //=========ACTIVE TAB STYLE=========
    
    func applyActiveStyle(button: UIButton) {
        button.isEnabled = true
        button.setTitleColor(UIColor(netHex: 0x8F00B3), for: .normal)
    }
    
    func translateTabHeaderUnderline(view: UIView, view_TabContainer: UIView) {
        let startPoint = CGPoint(x: view_TabContainer.frame.origin.x, y: view_TabContainer.frame.origin.y + view_TabContainer.frame.size.height)
        let endPoint = CGPoint(x: view_TabContainer.frame.origin.x + view_TabContainer.frame.size.width, y: view_TabContainer.frame.origin.y + view_TabContainer.frame.size.height)
        lineDrawer.addLine(fromPoint: startPoint, toPoint: endPoint, lineWidth: 3, color: UIColor(netHex: 0x8F00B3), view: view)
    }
}
