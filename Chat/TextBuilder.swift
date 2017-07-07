//
//  TextBuilder.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/7.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions


class ViewModel:TextMessageViewModel<TextModel>{
    
    override init(textMessage: TextModel , messageViewModel: MessageViewModelProtocol) {
        super.init(textMessage: textMessage, messageViewModel: messageViewModel)
    }
    
    
}

class TextBuilder : ViewModelBuilderProtocol{
    
    func canCreateViewModel(fromModel decoratedTextMessage:Any) -> Bool {
        return decoratedTextMessage is TextModel
        
    }
    
    func createViewModel(_ decoratedTextMessage: TextModel) -> ViewModel {
        
        let textmessageViewModel = ViewModel(textMessage: decoratedTextMessage, messageViewModel: MessageViewModelDefaultBuilder().createMessageViewModel(decoratedTextMessage))
        
        return textmessageViewModel
    
    }
}
