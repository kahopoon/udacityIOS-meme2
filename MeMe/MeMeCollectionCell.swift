//
//  MeMeCollectionCell.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class MeMeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    func initWithData(_ source: Meme) {
        memedImageView.image = source.memedImage
    }

}
