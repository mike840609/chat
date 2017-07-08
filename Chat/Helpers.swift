//
//  Helpers.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/8.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showingKeyboard(notification : Notification){
        if let keyboardheight = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height{
            self.view.frame.origin.y = -keyboardheight
        }
    }
    
    func hidingKeyboard(){
        self.view.frame.origin.y = 0
    }
    
    
}
