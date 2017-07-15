//
//  MessagesTableViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/15.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessagesTableViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Add(_ sender: Any) {
    }
    
    
    @IBAction func SignOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    

}
