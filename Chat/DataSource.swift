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
    

    
    var controller = ChatItemsController()
    
    init(totalMessages : [ChatItemProtocol]){
        self.controller.totalMessages = totalMessages
        // paging 0 - 50
        self.controller.loadIntoItemsArray(messagedNeeded: min(totalMessages.count , 50))
    }
    
    // protocol ===============================================================================
    
    var delegate: ChatDataSourceDelegateProtocol?
    
    var chatItems: [ChatItemProtocol]{
        return controller.items
    }
    
    
    var hasMoreNext: Bool{
        return false
    }
    var hasMorePrevious: Bool{
        return controller.totalMessages.count - controller.items.count > 0
    }
    
    func loadNext() {
        
    }
    
    func loadPrevious() {
        controller.loadPrevious()
        self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
        
    }
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: (Bool) -> Void) {
        completion(false)
    }
    
    
    // ========================================================================================
    
    func addMessage(message : ChatItemProtocol){
        
        self.controller.insertItem(message: message)
        self.delegate?.chatDataSourceDidUpdate(self)
        
    }
    
    
    
}
