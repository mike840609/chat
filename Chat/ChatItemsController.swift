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
        
        for index in stride(from: totalMessages.count - items.count , to: totalMessages.count - items.count - messagedNeeded, by: -1){
                self.items.insert(totalMessages[index - 1], at: 0)
        }
        
    }
    
    func insertItem(message : ChatItemProtocol){
        self.items.append(message)
        self.totalMessages.append(message)
    }
    
    func loadPrevious (){
        self.loadIntoItemsArray(messagedNeeded: min(totalMessages.count - items.count, 50))
    }
}
