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
    var dataSource  : DataSource!
    var decorator = Decorator()
    var totalMessage = [ChatItemProtocol]()
    
    
    override func createPresenterBuilders() -> [ChatItemType : [ChatItemPresenterBuilderProtocol]] {
        
        let textMessageBulider = TextMessagePresenterBuilder(viewModelBuilder: TextBuilder(),
                                                             interactionHandler: TextHandler())
        
        let photoPresenterBuilder = PhotoMessagePresenterBuilder(viewModelBuilder: PhotoBuilder(),
                                                                 interactionHandler: PhotoHanderler())
        
        
        return [TextModel.chatItemType : [textMessageBulider] ,
                PhotoModel.chatItemType : [photoPresenterBuilder]]
    }
    
    
    override func createChatInputView() -> UIView {
        let inputbar = ChatInputBar.loadNib()
        var appearance = ChatInputBarAppearance()
        
        appearance.sendButtonAppearance.title = "Send"
        appearance.textInputAppearance.placeholderText = "Type a message"
        
        self.presenter = BasicChatInputBarPresenter(chatInputBar: inputbar,
                                                    chatInputItems: [handleSend() ,handlephoto()],
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
            
            self.dataSource.addMessage(message: textMessage)
        }
        
        return item
    }
    
    
    func handlephoto() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        
        item.photoInputHandler = { photo in
            
            let date = Date()
            let double = Double(date.timeIntervalSinceReferenceDate)
            
            let senderID = "me"
            
            let message = MessageModel(uid: "\(double,senderID)", senderId: senderID , type: PhotoModel.chatItemType, isIncoming: false, date: date, status: .success)
            
            let photoMessage = PhotoModel(messageModel: message, imageSize: photo.size, image: photo)
            
            self.dataSource.addMessage(message: photoMessage)
            
        }
        
        return item
    }
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...295{
            let message = MessageModel(uid: "\(i)", senderId: "", type: TextModel.chatItemType, isIncoming: false, date: Date(), status: .success)
            self.totalMessage.append(TextModel(messageModel: message, text: "\(i)"))
        }
        
        self.chatDataSource = self.dataSource
        self.chatItemsDecorator = self.decorator
        
    }
    
    
    
}

