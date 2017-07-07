//
//  TextHandler.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/7.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

class TextHandler : BaseMessageInteractionHandlerProtocol{
    
    func userDidTapOnFailIcon(viewModel: ViewModel, failIconView: UIView){
        print(#function)
        
    }
    func userDidTapOnAvatar(viewModel: ViewModel){
        print(#function)
        
    }
    func userDidTapOnBubble(viewModel: ViewModel){
        print(viewModel.text)
        print(#function)
        
    }
    func userDidBeginLongPressOnBubble(viewModel: ViewModel){
        print(#function)
        
    }
    func userDidEndLongPressOnBubble(viewModel: ViewModel){
        print(#function)
        
        
    }
}
