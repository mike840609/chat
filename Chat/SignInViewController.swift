//
//  SignInViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/8.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector (showingKeyboard), name: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector (hidingKeyboard), name: Notification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
        guard let email = email.text , let psd = password.text else { return}
        
        Auth.auth().signIn(withEmail: email, password: psd) { [weak self](user, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.alert(message: error.localizedDescription)
                return
            }
            
            
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MessagesTable") as! MessagesTableViewController
            
            self?.navigationController?.show(vc, sender: nil)

        }
        
    
        
    }

    @IBAction func SignUp(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SIGNUP") as! SignUpViewController
        
        self.navigationController?.show(controller, sender: nil)
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
