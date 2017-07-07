//
//  PhotoModel.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/7.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class PhotoModel : PhotoMessageModel<MessageModel>{
    override init(messageModel: MessageModel, imageSize: CGSize, image: UIImage) {
        super.init(messageModel: messageModel, imageSize: imageSize, image: image)
    }
}
