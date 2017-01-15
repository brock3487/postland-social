//
//  FancyButtonSignIn.swift
//  PostLand
//
//  Created by Admin on 15/01/2017.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

class FancyButtonSignIn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
