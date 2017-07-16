//
//  MessagesTableViewController.swift
//  Chat
//
//  Created by 蔡鈞 on 2017/7/15.
//  Copyright © 2017年 蔡鈞. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseUI
import SwiftyJSON


class MessagesTableViewController: UIViewController {
    
    let Contacts = FUIArray(query: Database.database().reference()
        .child(USERS).child(Auth.auth().currentUser!.uid).child(CONTACTS))
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // observe array
        self.Contacts.observeQuery()
        self.Contacts.delegate = self
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Add(_ sender: Any) {
        self.presentAlert()
    }
    
    
    @IBAction func SignOut(_ sender: Any) {
        try! Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    func presentAlert(){
        let alertController = UIAlertController(title: "Email?", message: "Please write the email : ", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self](_) in
            if let email = alertController.textFields?[0].text{
                self?.addContact(email: email)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func addContact(email:String){
        
        Database.database().reference().child("Users").observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
            
            print(snapshot)
            
            let snapshot = JSON(snapshot.value as Any).dictionaryValue
            
            if let index = snapshot.index(where: { (key , value) -> Bool in
                
                return value["email"].stringValue == email
                
            }){
                Database.database().reference().child(USERS).child(Auth.auth().currentUser!.uid)
                    .child("Contacts")
                    .child(snapshot[index].key)
                    .updateChildValues(["email" : snapshot[index].value["email"].stringValue ,
                                        "name" : snapshot[index].value["name"].stringValue])
                
                
                Database.database().reference().child(USERS).child(snapshot[index].key)
                    .child("Contacts")
                    .child(Auth.auth().currentUser!.uid)
                    .updateChildValues(["email" : Auth.auth().currentUser!.email! ,
                                        "name" : Auth.auth().currentUser!.displayName!])
                
                let allUpdates =
                    ["/Users/\(Auth.auth().currentUser!.uid)/Contacts/\(snapshot[index].key)":
                        (["email" : snapshot[index].value["email"].stringValue ,"name" : snapshot[index].value["name"].stringValue]),
                     
                     "/Users/\(snapshot[index].key)/Contacts/\(Auth.auth().currentUser!.uid)":
                        (["email" : Auth.auth().currentUser!.email! ,"name" : Auth.auth().currentUser!.displayName!])
                    ]
                
                Database.database().reference().updateChildValues(allUpdates)
                
                
                
                self?.alert(message: "success")
                
            }else{
                
                self?.alert(message: "no such email")
                
            }
            
        })
    }
}

extension MessagesTableViewController : FUICollectionDelegate{
    
    func array(_ array: FUICollection, didAdd object: Any, at index: UInt) {
        self.tableView.insertRows(at: [IndexPath(row : Int(index) , section : 0)], with: .automatic)
    }
    
    func array(_ array: FUICollection, didMove object: Any, from fromIndex: UInt, to toIndex: UInt) {
        self.tableView.insertRows(at: [IndexPath(row : Int(fromIndex) , section : 0)], with: .automatic)
        self.tableView.deleteRows(at: [IndexPath(row : Int(toIndex) , section : 0)], with: .automatic)
    }
    
    func array(_ array: FUICollection, didRemove object: Any, at index: UInt) {
        self.tableView.deleteRows(at: [IndexPath(row : Int(index) , section : 0)], with: .automatic)
    }
    
    func array(_ array: FUICollection, didChange object: Any, at index: UInt) {
        self.tableView.reloadRows(at: [IndexPath(row : Int(index) , section : 0)], with: .automatic)
    }
}

extension MessagesTableViewController: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(Contacts.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessagesTableViewCell
        
        let info = JSON((Contacts[(UInt(indexPath.row))] as? DataSnapshot)?.value as Any).dictionaryObject
        
        cell.name.text = info?["name"] as? String
        cell.lastMessageDate.text = nil
        return cell
        
    }
}
