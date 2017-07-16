//
//  SignUpViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/8.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var fullname: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector (showingKeyboard), name: Notification.Name(rawValue: "UIKeyboardWillShowNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector (hidingKeyboard), name: Notification.Name(rawValue: "UIKeyboardWillHideNotification"), object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func SignUp(_ sender: Any) {
        guard let email = email.text , let psd = password.text , let fullname = fullname.text else { return }
        Auth.auth().createUser(withEmail: email, password: psd) { [weak self] (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
                self?.alert(message: error.localizedDescription)
                return
            }
            
            // store the data to database
            Database.database().reference().child(USERS).child(user!.uid).updateChildValues(["email" : email , "name" : fullname])
            
            let changeRequest = user!.createProfileChangeRequest()
            changeRequest.displayName = fullname
            changeRequest.commitChanges(completion: nil)
            
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MessagesTable") as! MessagesTableViewController
            
            self?.navigationController?.show(vc, sender: nil)
            
            
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
