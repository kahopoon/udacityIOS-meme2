//
//  Singleton.swift
//  MeMe
//
//  Created by Ka Ho Poon on 22/1/2017.
//  Copyright © 2017 Ka Ho Poon. All rights reserved.
//

import Foundation

class Singleton {
    
    public static var sharedInstace = Singleton()
    private init() {
        savedMeme = memeGetFromUserDefaults()
    }
    
    private var savedMeme:[Meme] = []
    
    func getMeMe() -> [Meme] {
        return savedMeme
    }
    
    func appendMeMe(_ element: Meme) {
        savedMeme.append(element)
        memeSaveToUserDefaults()
    }
    
    private func memeSaveToUserDefaults() {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: savedMeme)
        UserDefaults.standard.set(encodedData, forKey: "meme")
        UserDefaults.standard.synchronize()
    }
    
    private func memeGetFromUserDefaults() -> [Meme] {
        guard let decoded = UserDefaults.standard.object(forKey: "meme") else {
            return []
        }
        return NSKeyedUnarchiver.unarchiveObject(with: decoded as! Data) as! [Meme]
    }
    
}
