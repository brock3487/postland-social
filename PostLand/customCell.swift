//
//  customCell.swift
//  PostLand
//
//  Created by Admin on 16/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var placeholderImg: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var likeCount: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
