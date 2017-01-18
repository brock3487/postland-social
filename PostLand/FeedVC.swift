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

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        DataService.ds.REF_POSTS.observe(.value) { (snapshot) in    //for realtime Updating data!!!
            print(snapshot.value)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCell(withIdentifier: "reuseCell") as! CustomCell
    }
    

    @IBAction func signOutTapped(_ sender: Any) {
        let keyChain = KeychainWrapper.standard.remove(key: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("BROCK: Attempt to sign out is \(keyChain)")
        performSegue(withIdentifier: "SignInVC", sender: nil)
    }

    
    
}
