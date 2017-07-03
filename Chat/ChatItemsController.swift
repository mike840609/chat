//
//  ChatItemsController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/4.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class ChatItemsController{
    
    var items = [ChatItemProtocol]()
    
    func insertItem(message : ChatItemProtocol){
        self.items.append(message)
    }
}
