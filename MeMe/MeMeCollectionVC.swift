//
//  MeMeCollectionVC.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "memeCell"

class MeMeCollectionVC: UICollectionViewController {

    var memeImages:[Meme] = Singleton.sharedInstace.getMeMe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memeImages = Singleton.sharedInstace.getMeMe()
        collectionView?.reloadData()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MeMeCollectionCell
        cell.initWithData(memeImages[indexPath.item])
    
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    @IBAction func addMeMeAction(_ sender: Any) {
        let addMeMeVC = storyboard?.instantiateViewController(withIdentifier: "AddNewVC") as! AddNewVC
        present(addMeMeVC, animated: true, completion: nil)
    }

}
