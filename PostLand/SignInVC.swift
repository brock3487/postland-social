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

class SignInVC: UIViewController {
    @IBOutlet weak var emailLoginField: FancyTextField!
    @IBOutlet weak var passwordField: FancyTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil{
                print("BROCK: Unable to authenticate with Firebase")
            }else{
                print("BROCK: Succesfully authenticated with Firebase")
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
    
    @IBAction func signInBtn(_ sender: Any) {
        if let email = emailLoginField.text, let password = passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil{
                    print("BROCK: User athenticated with Firebase Succesfully")
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil{
                            
                        print("BROCK: Unable to authenticate with Firebase")
                        }else{
                                print("BROCK: Successfully authenticated with Firebase")
                            }
                    })
                }
            })
        }
        
        
    }
}

















