//
//  Meme.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class Meme : NSObject, NSCoding {
    
    let topText:String
    let bottomText:String
    let originalImage:UIImage
    let memedImage:UIImage
    
    init(topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage) {
        self.topText        = topText
        self.bottomText     = bottomText
        self.originalImage  = originalImage
        self.memedImage     = memedImage
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let topText = aDecoder.decodeObject(forKey: "topText") as! String
        let bottomText = aDecoder.decodeObject(forKey: "bottomText") as! String
        let originalImage = aDecoder.decodeObject(forKey: "originalImage") as! UIImage
        let memedImage = aDecoder.decodeObject(forKey: "memedImage") as! UIImage
        self.init(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImage: memedImage)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(topText, forKey: "topText")
        aCoder.encode(bottomText, forKey: "bottomText")
        aCoder.encode(originalImage, forKey: "originalImage")
        aCoder.encode(memedImage, forKey: "memedImage")
    }
    
}
