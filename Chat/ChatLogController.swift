//
//  ViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/2.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import Chatto
import ChattoAdditions


class ChatLogController: BaseChatViewController {
    
    var presenter: BasicChatInputBarPresenter!
    
    
    override func createPresenterBuilders() -> [ChatItemType : [ChatItemPresenterBuilderProtocol]] {
        return [ChatItemType : [ChatItemPresenterBuilderProtocol]]()
    }
    
    
    override func createChatInputView() -> UIView {
        let inputbar = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        
        appearance.sendButtonAppearance.title = "Send"
        appearance.textInputAppearance.placeholderText = "Type a message"
        
        self.presenter = BasicChatInputBarPresenter(chatInputBar: inputbar,
                                                    chatInputItems: [handleSend()],
                                                    chatInputBarAppearance: appearance)
        
        return inputbar
    }
    
    
    func handleSend () -> TextChatInputItem{
        let item = TextChatInputItem()
        item.textInputHandler = { text in
            //            print(text)
            
            let message = MessageModel(uid: "", senderId: "", type: "", isIncoming: false, date: Date(), status: .success)
            let textMessage = TextModel(messageModel: message, text: text)
        }
        
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

