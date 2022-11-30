//
//  UserDafultData.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/29.
//

import Foundation


class UserDefaultData {
    
    let defaults = UserDefaults.standard
    
    // Find Plist Path
    static func findPath() {
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    static let shared:UserDefaultData = {
        let instance = UserDefaultData()
        
        // SetUp

        return instance
    }()
    
    init() {
        self.backgroundMusic = UserDefaults.standard.bool(forKey: "BackgroundMusic")
        self.inGameSound = UserDefaults.standard.bool(forKey: "InGameSound")
        self.playerSkin = UserDefaults.standard.string(forKey: "PlayerSkin") ?? "default"
        self.nowNumber = 0
        self.isClear = false
        self.myRecord = 0.0
        self.star = 0
        self.isLock = false
        self.jumpData = 0
        self.breakData = 0
        self.collisionData = 0
    }
    
    
    // Setting
    var backgroundMusic:Bool = false
    var inGameSound:Bool = false
    
    func settingSave(backgroundMusic:Bool, inGameSound:Bool) {
        defaults.set(backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(backgroundMusic, forKey: "InGameMusic")
    }
    
    // PlayerSkin
    var playerSkin:String = "default"
    
    func playerSkinSave(playerSkin:String) {
        defaults.set(playerSkin,forKey: "PlayerSkin")
    }
    
    // Quest
    var nowNumber:Int
    var isClear:Bool
    
    // Stage
    var myRecord:Double
    var star:Int
    var isLock:Bool
    
    // Tracking Data
    var jumpData:Int
    var breakData:Int
    var collisionData:Int
    
    
}


extension UserDefaults {
    
    // MARK: UserDefault Object 변환사용
    func setUserDefaultObject<T: Codable>(_ data: T?, forKey defaultName:String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded,  forKey: defaultName)
    }
    func userDefaultObject<T: Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
