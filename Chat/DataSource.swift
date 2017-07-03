//
//  DataSource.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/4.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class DataSource: ChatDataSourceProtocol{
    

    var delegate: ChatDataSourceDelegateProtocol?
    
    var controller = ChatItemsController()
    
    var chatItems: [ChatItemProtocol]{
        return controller.items
    }
    
    
    var hasMoreNext: Bool{
        return false
    }
    var hasMorePrevious: Bool{
        return false
    }
    
    func loadNext() {
        
    }
    
    func loadPrevious() {
        
    }
    
    func addTextMessage(message : ChatItemProtocol){
        
        self.controller.insertItem(message: message)
        
    }
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: (Bool) -> Void) {
        completion(false)
    }
    
    
    
}
