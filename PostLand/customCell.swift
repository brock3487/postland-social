//
//  customCell.swift
//  PostLand
//
//  Created by Admin on 16/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit
import Firebase

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var placeholderImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var likeCount: UILabel!
    
    var postData: Post?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(post: Post, img: UIImage? = nil){
        self.postData = post
        self.textView.text = postData?.caption
        self.likeCount.text = "\(postData!.likes)"
        
        if img != nil{
            
            self.placeholderImg.image = img
        }else{
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil{
                        print("BROCK: Unable to download data from firebase")
                    }else{
                        print("BROCK: Image downloaded from firebase")
                        if let imgData = data{
                            if let img = UIImage(data: imgData){
                                self.placeholderImg.image = img
                                FeedVC.imgCache.setObject(img, forKey: post.imageUrl as NSString)
                            }
                        }
                    }
                })
            
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
