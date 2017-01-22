//
//  Meme.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

struct Meme {
    
    var topText:String
    var bottomText:String
    var originalImage:UIImage
    var memedImage:UIImage
    
    init(topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage) {
        self.topText        = topText
        self.bottomText     = bottomText
        self.originalImage  = originalImage
        self.memedImage     = memedImage
    }
    
}
