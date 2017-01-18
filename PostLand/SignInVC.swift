//
//  SignInVC.swift
//  PostLand
//
//  Created by Admin on 14/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    @IBOutlet weak var emailLoginField: FancyTextField!
    @IBOutlet weak var passwordField: FancyTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Can't perform segues because it's calling it to earlier
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            
            performSegue(withIdentifier: "FeedVC", sender: nil)
            
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
                
                print("BROCK: Unable to authenticate with Firebase")
            }else{
                
                print("BROCK: Succesfully authenticated with Firebase")
                
                if let user = user{
                    
                    let userData = ["provider": credential.provider]
                    
                    self.completeSignIn(id: user.uid, userData: userData)
                    
                }
                
            }
        })
    }


    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
                
                print("BROCK: Unable to authenticate with Facebook")
            }else if result?.isCancelled == true{
                
                print("BROCK: User authenticate is cancelled")
            }else{
                
                print("BROCK: Succesfully authenticated with Facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                           }
    }
}
    
    
    func completeSignIn(id: String, userData: Dictionary<String, String>){
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
       let keyChain = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "FeedVC", sender: nil)
        print("BROCK: Status of saved data - \(keyChain)")
    }
    
    
    @IBAction func signInBtn(_ sender: Any) {
        if let email = emailLoginField.text, let password = passwordField.text{
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil{
                    print("BROCK: User athenticated with Firebase Succesfully")
                    
                    if let user = user{
                        
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                    
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil{
                            
                        print("BROCK: Unable to authenticate with Firebase")
                        }else{
                                print("BROCK: Successfully created user with Firebase")
                            
                            if let user = user{
                                
                                let userData = ["provide": user.providerID]
                                
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                            }
                    })
                }
            })
        }
        
        
    }
}

















