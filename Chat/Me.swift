//
//  Me.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/19.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import FirebaseAuth

class Me {
    static var uid : String{
        return Auth.auth().currentUser!.uid
    }
}
