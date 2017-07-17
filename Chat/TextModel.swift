//
//  TextModel.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/3.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class TextModel:TextMessageModel<MessageModel>{
    
    static let chatItemType = "text"
    
    override init(messageModel : MessageModel , text :String){
        
        super.init(messageModel : messageModel , text:text)
    
    }
    
    var status: MessageStatus{
        get{
            return self._messageModel.status
        }
        set{
            self._messageModel.status = newValue
        }
    }
    
}
