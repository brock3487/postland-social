//
//  DataService.swift
//  PostLand
//
//  Created by Admin on 17/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()  //for pictures storage

class DataService{
    //DB references
    static let ds = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    //Storage references
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    
    
    var REF_BASE: FIRDatabaseReference{
    return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    var REF_POST_IMAGES: FIRStorageReference{
        return _REF_POST_IMAGES
    }


    
   func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>){
    
    REF_USERS.child(uid).updateChildValues(userData)
    }
    
}
