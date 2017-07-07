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
    
    var dataSource  = DataSource()
    var decorator = Decorator()
    
    
    override func createPresenterBuilders() -> [ChatItemType : [ChatItemPresenterBuilderProtocol]] {
        
        let textMessageBulider = TextMessagePresenterBuilder(viewModelBuilder: TextBuilder(),
                                                             interactionHandler: TextHandler())
        
        return [TextModel.chatItemType : [textMessageBulider]]
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
            
            let date = Date()
            let double = Double(date.timeIntervalSinceReferenceDate)
            
            let senderID = "me"
            
            let message = MessageModel(uid: "\(double,senderID)", senderId: senderID , type: TextModel.chatItemType, isIncoming: false, date: date, status: .success)
            
            let textMessage = TextModel(messageModel: message, text: text)
            
            self.dataSource.addTextMessage(message: textMessage)
        }
        
        return item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatDataSource = self.dataSource
        self.chatItemsDecorator = self.decorator
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}

