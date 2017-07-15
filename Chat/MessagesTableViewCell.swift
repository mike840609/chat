//
//  MessagesTableViewCell.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/15.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var lastMessageDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
