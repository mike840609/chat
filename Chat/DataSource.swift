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
    var currentlyLoading = false
    
    
    init(initialMessages : [ChatItemProtocol] , uid :String){
        self.controller.initialMessages = initialMessages
        self.controller.userUID = uid
        // paging 0 - 50
        self.controller.loadIntoItemsArray(messagedNeeded: min(initialMessages.count , 50),
                                           moreToLoad : initialMessages.count > 50)
    }
    
    // protocol ===============================================================================
    
    // use weak var to avoid memory leak
    weak var delegate: ChatDataSourceDelegateProtocol?
    
    var chatItems: [ChatItemProtocol]{
        return controller.items
    }
    
    
    var hasMoreNext: Bool{
        return false
    }
    var hasMorePrevious: Bool{
        
        return controller.loadMore
    }
    
    func loadNext() {
        
    }
    
    func loadPrevious() {
        if currentlyLoading == false{
            currentlyLoading = true
            controller.loadPrevious {
                self.delegate?.chatDataSourceDidUpdate(self, updateType: .pagination)
                self.currentlyLoading = false
                
            }
        }
        
    }
    
    func adjustNumberOfMessages(preferredMaxCount: Int?, focusPosition: Double, completion: (Bool) -> Void) {
        
        if focusPosition > 0.9{
            
            self.controller.adjustWindows()
            completion(true)
            
        }else{
            
            completion(false)
        }
        
        
    }
    
    
    // ========================================================================================
    
    func addMessage(message : ChatItemProtocol){
        
        self.controller.insertItem(message: message)
        self.delegate?.chatDataSourceDidUpdate(self)
        
    }
    
    
    func updateTextMessage (uid :String , status : MessageStatus){
        if let index = self.controller.items.index(where: { (message) -> Bool in
            return message.uid == uid
        }){
            let message = self.controller.items[index] as! TextModel
            message.status = status
            self.delegate?.chatDataSourceDidUpdate(self)
        }
    }
    
}
