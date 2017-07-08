//
//  SignUpViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/8.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var fullname: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        guard let email = email.text , let psd = password.text , let fullname = fullname.text else { return }
        Auth.auth().createUser(withEmail: email, password: psd) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print("success")
        }
        
    }
    
    @IBAction func Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
