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
import FirebaseDatabase
import SwiftyJSON

class ChatItemsController : NSObject{
    
    var items = [ChatItemProtocol]()
    var initialMessages = [ChatItemProtocol]()
    var loadMore = false
    var userUID :String!
    typealias completeLoading = () -> Void
    
    func loadIntoItemsArray(messagedNeeded : Int , moreToLoad:Bool){
        
        for index in stride(from: initialMessages.count - items.count , to: initialMessages.count - items.count - messagedNeeded, by: -1){
                self.items.insert(initialMessages[index - 1], at: 0)
            self.loadMore = moreToLoad
        }
        
    }
    
    func insertItem(message : ChatItemProtocol){
        self.items.append(message)
        
    }
    
    func loadPrevious (completion : @escaping completeLoading ){
        Database.database().reference().child("User-messages").child(Me.uid).child(userUID)
            .queryEnding(atValue: nil, childKey: self.items.first?.uid).queryLimited(toLast: 52)
            .observeSingleEvent(of: .value, with: { [weak self](snapshot) in
                
                var messages = Array(JSON(snapshot.value as Any).dictionaryValue.values).sorted(by: { (lhs, rhs) -> Bool in
                    return lhs["date"].doubleValue < rhs["date"].doubleValue
                })
                
                messages.removeLast()
                self?.loadMore = messages.count > 50
                let converted = self!.convertToChatItemProcotol(messages: messages)
                
                for index in stride(from: converted.count, to: converted.count - min(messages.count, 50), by: -1){
                    self?.items.insert(converted[index - 1 ], at: 0)
                }
                
                completion()
            })
    }
    
    func adjustWindows (){
        self.items.removeFirst(200)
    }
}
