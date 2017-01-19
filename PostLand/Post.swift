//
//  Post.swift
//  PostLand
//
//  Created by Admin on 19/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import Foundation

class Post{
    
    private var _imageUrl: String!
    private var _caption: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var imageUrl: String{
        return _imageUrl
    }
    var caption: String{
        return _caption
    }
    var likes: Int{
        return _likes
    }
    var postKey: String{
        return _postKey
    }
    
    init(caption: String, likes: Int, imageUrl: String) {
        self._caption = caption
        self._likes = likes
        self._imageUrl = imageUrl
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>){
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String{
            self._caption = caption
        }
        if let imageUrl = postData["imageUrl"] as? String{
            self._imageUrl = imageUrl
        }
        if let likes = postData["likes"] as? Int{
            self._likes = likes
        }
        
        
    }
    
    
}
