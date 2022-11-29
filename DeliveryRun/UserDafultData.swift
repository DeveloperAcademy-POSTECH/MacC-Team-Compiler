//
//  UserDafultData.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/29.
//

import Foundation


class UserDefaultData {
    static let shared = UserDefaultData()
    init() {
        
        self.backgroundMusic = defaults.bool(forKey: "BackgroundMusic")
        self.inGameSound = defaults.bool(forKey: "InGameSound")
    }
    
    var backgroundMusic:Bool = false
    var inGameSound:Bool = false
    
    var playerSkin:String = "default"
    
    var nowNumber:Int = 0
    var isClear:Bool = false
    
    var myRecord:Double = 0.0
    var star:Int = 0
    var isLock:Bool = false
    
    func setSetting(backgroundMusic:Bool, inGameSound:Bool) {
        defaults.set(backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(inGameSound, forKey: "InGameSound")
    }
    
    func setPlayerSkin(skinName:String) {
        defaults.set(skinName, forKey: "PlayerSkin")
    }
    
    func setQuest(nowNumber:Int, isClear:Bool) {
        defaults.set(nowNumber, forKey: "NowNumber")
        defaults.set(isClear, forKey: "IsClaer")
    }
    
    func setStage(myRecord:Double, satr:Int, isLock:Bool) {
        defaults.set(myRecord, forKey: "MyRecord")
        defaults.set(isLock, forKey: "IsLock")
    }
    
    let defaults = UserDefaults.standard
    
}
