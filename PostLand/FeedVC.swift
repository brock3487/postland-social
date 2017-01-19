//
//  FeedVC.swift
//  PostLand
//
//  Created by Admin on 16/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
       
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in    //for realtime Updating data!!!
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]{
                
                for snap in snapshots{
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject>{
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CustomCell{
            
            cell.configureCell(post: post)
            
            return cell
        }else{
            
            return CustomCell()
        }
        
        
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        let keyChain = KeychainWrapper.standard.remove(key: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("BROCK: Attempt to sign out is \(keyChain)")
        performSegue(withIdentifier: "SignInVC", sender: nil)
    }

    
    
}
