//
//  ShowMeMeDetails.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class ShowMeMeDetails: UIViewController {

    @IBOutlet weak var memedImageView: UIImageView!
    
    var meme:Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let MeMe = meme {
            memedImageView.image = MeMe.memedImage
        }
    }

}
