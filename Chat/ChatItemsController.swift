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
    var totalMessages = [ChatItemProtocol]()
    
    func loadIntoItemsArray(messagedNeeded : Int){
        
        for index in stride(from: totalMessages.count, to: totalMessages.count - messagedNeeded, by: -1){
                self.items.insert(totalMessages[index - 1], at: 0)
        }
        
    }
    
    func insertItem(message : ChatItemProtocol){
        self.items.append(message)
    }
}
