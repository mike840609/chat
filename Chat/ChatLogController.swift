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
import FirebaseAuth
import FirebaseDatabase


class ChatLogController: BaseChatViewController {
    
    var presenter: BasicChatInputBarPresenter!
    var dataSource  : DataSource!
    var decorator = Decorator()
    
    var userUID = String()
    
    
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
        item.textInputHandler = { [weak self] text in
            
            let date = Date()
            let double = Double(date.timeIntervalSinceReferenceDate)
            
            let senderID = Auth.auth().currentUser!.uid
            let messageUID = (senderID + "\(double)").replacingOccurrences(of: ".", with: "")
            
            let message = MessageModel(uid: messageUID, senderId: senderID , type: TextModel.chatItemType, isIncoming: false, date: date, status: .sending)
            
            let textMessage = TextModel(messageModel: message, text: text)
            
            self?.dataSource.addMessage(message: textMessage)
            
            self?.sendOnlineTextMessage(text: text, uid: messageUID, double: double, senderId: senderID)
        }
        
        return item
    }
    
    
    func handlephoto() -> PhotosChatInputItem {
        let item = PhotosChatInputItem(presentingController: self)
        
        item.photoInputHandler = { [weak self] photo in
            
            let date = Date()
            let double = Double(date.timeIntervalSinceReferenceDate)
            
            let senderID = "me"
            
            let message = MessageModel(uid: "\(double,senderID)", senderId: senderID , type: PhotoModel.chatItemType, isIncoming: false, date: date, status: .success)
            
            let photoMessage = PhotoModel(messageModel: message, imageSize: photo.size, image: photo)
            
            self?.dataSource.addMessage(message: photoMessage)
            
        }
        
        return item
    }
    
    
    func sendOnlineTextMessage (text:String , uid:String ,double:Double ,senderId : String){
        
        let message = ["text " :text , "uid ":uid , "date ":double  , "senderId":senderId , "status": "success"] as [String :Any]
        
        let childUpdates = ["User-messages/\(senderId)/\(self.userUID)/\(uid)":message ,
                            "User-messages/\(self.userUID)/\(senderId)/\(uid)":message ,]
        
        Database.database().reference().updateChildValues(childUpdates) { (error, _) in
            if error != nil{
                self.dataSource.updateTextMessage(uid: uid, status: .failed)
            }
            self.dataSource.updateTextMessage(uid: uid, status: .success)
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.chatDataSource = self.dataSource
        self.chatItemsDecorator = self.decorator
        
        self.constants.preferredMaxMessageCount = 300
        
    }
    
    
    
    
}

