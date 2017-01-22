//
//  MeMeTableCell.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class MeMeTableCell: UITableViewCell {

    @IBOutlet weak var memedImageView: UIImageView!
    @IBOutlet weak var topAndBottomTextLabel: UILabel!

    func initWithData(_ source: Meme) {
        memedImageView.image        = source.memedImage
        topAndBottomTextLabel.text  = "\(source.topText)...\(source.bottomText)"
    }

}
