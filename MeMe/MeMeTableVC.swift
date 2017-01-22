//
//  MeMeTableVC.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import UIKit

class MeMeTableVC: UITableViewController {

    var memedImages:[Meme] = Singleton.sharedInstace.getMeMe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memedImages = Singleton.sharedInstace.getMeMe()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memedImages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! MeMeTableCell
        cell.initWithData(memedImages[indexPath.row])
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailsVC = storyboard?.instantiateViewController(withIdentifier: "ShowMeMeDetails") as! ShowMeMeDetails
        memeDetailsVC.meme = memedImages[indexPath.row]
        navigationController?.pushViewController(memeDetailsVC, animated: true)
    }
    
    @IBAction func addMeMeAction(_ sender: Any) {
        let addMeMeVC = storyboard?.instantiateViewController(withIdentifier: "AddNewVC") as! AddNewVC
        present(addMeMeVC, animated: true, completion: nil)
    }


}
