//
//  UserDafultData.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/29.
//

import Foundation


class UserDefaultData {
    
    static let staticDefaults = UserDefaults.standard
    let defaults = UserDefaults.standard
    
    // Find Plist Path
    static func findPath() {
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
    static let shared:UserDefaultData = {
        let instance = UserDefaultData()
        return instance
    }()
    
    init() {
        self.backgroundMusic = UserDefaults.standard.bool(forKey: "BackgroundMusic")
        self.inGameSound = UserDefaults.standard.bool(forKey: "InGameSound")
        self.myPlayerSkin = UserDefaults.standard.string(forKey: "MyPlayerSkin") ?? "default"
        if let mySkinList = UserDefaults.standard.array(forKey: "MySkinList") {
            self.mySkinList = mySkinList as! [String]
        } else {
            self.mySkinList = ["default"]
        }
        self.jumpData = UserDefaults.standard.integer(forKey: "JumpData")
        self.breakData = UserDefaults.standard.integer(forKey: "BreakData")
        self.collisionData = UserDefaults.standard.integer(forKey: "CollisionData")
        
        // Quest Setting
        self.firstQuestIsClear = UserDefaults.standard.bool(forKey: "FirstQuestIsClear")
        
        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jump", totalNumber: 50, nowNumber: self.jumpData, isClear: self.firstQuestIsClear)
        self.firstQuest = quest1
        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "Quest1")
        
        self.secondQuestIsClear = UserDefaults.standard.bool(forKey: "SecondQuestIsClear")
        let quest2 = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "break", totalNumber: 20, nowNumber: self.breakData, isClear: self.secondQuestIsClear)
        self.secondQuest = quest2
        UserDefaults.standard.setObjectToUserDefault(quest2, forKey: "Quest2")
        
        self.thirdQuestIsClear = UserDefaults.standard.bool(forKey: "ThirdQuestIsClear")
        let quest3 = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collision", totalNumber: 50, nowNumber: self.collisionData, isClear: self.thirdQuestIsClear)
        self.thirdQuest = quest3
        UserDefaults.standard.setObjectToUserDefault(quest3, forKey: "Quest3")
        
        
        // Stage Setting
        self.firstStageRecord = UserDefaults.standard.double(forKey: "Record1")
        self.firstStageClear = UserDefaults.standard.bool(forKey: "FirstStageClear")
        
        self.secondStageRecord = UserDefaults.standard.double(forKey: "Record2")
        self.secondStageClear = UserDefaults.standard.bool(forKey: "SecondStageClear")
        
        self.thirdStageRecodrd = UserDefaults.standard.double(forKey: "Record3")
        self.thirdStageClear = UserDefaults.standard.bool(forKey: "ThirdStageClear")
        
        self.fourStageRecord = UserDefaults.standard.double(forKey: "Record4")
        self.fourStageClear = UserDefaults.standard.bool(forKey: "FourStageClear")
        
        self.fiveStageRecord = UserDefaults.standard.double(forKey: "Record5")
        self.fiveStageClear = UserDefaults.standard.bool(forKey: "FiveStageClear")
        
        let stage1 = Stage(name: "스테이지 1", image: "star0", targetRecord: 50.0, myRecord: self.firstStageRecord, isLock: false)
        self.firstStage = stage1
        UserDefaults.standard.setObjectToUserDefault(stage1, forKey: "Stage1")
        
        let stage2 = Stage(name: "스테이지 2", image: "star0", targetRecord: 60.0, myRecord: self.secondStageRecord, isLock: !self.firstStageClear)
        self.secondStage = stage2
        UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "Stage2")
        
        let stage3 = Stage(name: "스테이지 3", image: "star0", targetRecord: 70.0, myRecord: self.thirdStageRecodrd, isLock: !self.secondStageClear)
        self.thirdStage = stage3
        UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "Stage3")
        
        let stage4 = Stage(name: "스테이지 4", image: "star0", targetRecord: 80.0, myRecord: self.fourStageRecord, isLock: !self.thirdStageClear)
        self.fourStage = stage4
        UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "Stage4")
        
        let stage5 = Stage(name: "스테이지 5", image: "star0", targetRecord: 90.0, myRecord: self.fiveStageRecord, isLock: !self.fourStageClear)
        self.fiveStage = stage5
        UserDefaults.standard.setObjectToUserDefault(stage5, forKey: "Stage5")
    }
    
    // Setting
    var backgroundMusic:Bool = false
    var inGameSound:Bool = false
    
    func settingSave(backgroundMusic:Bool, inGameSound:Bool) {
        defaults.set(backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(backgroundMusic, forKey: "InGameMusic")
    }

    // PlayerSkin
    var SkinList:[String] = ["default", "jump", "break", "collision"]
    var mySkinList:[String]
    var myPlayerSkin:String = "default"
    
    func getSkin(skinName:String) {
        mySkinList.append(skinName)
        defaults.set(mySkinList, forKey: "MySkinList")
        
    }
    
    func setMySkin(skinName:String) {
        defaults.set(myPlayerSkin, forKey: "MyPlayerSkin")
    }
    
    // Quest
    var firstQuest:Quest
    var secondQuest:Quest
    var thirdQuest:Quest
    
    var firstQuestIsClear:Bool = false
    var secondQuestIsClear:Bool = false
    var thirdQuestIsClear:Bool = false
    
    func firstQuestCompleted() {
        defaults.set(true, forKey: "FirstQuestIsClear")
        getSkin(skinName: "jump")
    }
    
    func secondQuestCompleted() {
        defaults.set(true, forKey: "SecondQuestIsClear")
        getSkin(skinName: "break")
    }
    
    func thirdQuestComplted() {
        defaults.set(true, forKey: "ThirdQuestIsClear")
        getSkin(skinName: "collision")
    }
    
    // Stage
    var firstStage:Stage
    var secondStage:Stage
    var thirdStage:Stage
    var fourStage:Stage
    var fiveStage:Stage
    
    var firstStageRecord:Double = 0.0
    var secondStageRecord:Double = 0.0
    var thirdStageRecodrd:Double = 0.0
    var fourStageRecord:Double = 0.0
    var fiveStageRecord:Double = 0.0
    
    var firstStageClear:Bool = false
    var secondStageClear:Bool = false
    var thirdStageClear:Bool = false
    var fourStageClear:Bool = false
    var fiveStageClear:Bool = false
    
    func firstStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record1")
        defaults.set(true, forKey: "FirstStageClear")
    }
    
    func secondStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record2")
        defaults.set(true, forKey: "SecondStageClear")
    }
    func thirdStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record3")
        defaults.set(true, forKey: "ThirdStageClear")
    }
    func fourStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record4")
        defaults.set(true, forKey: "FourStageClear")
    }
    func fiveStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record5")
        defaults.set(true, forKey: "FiveStageClear")
    }
    
    // Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    func trackingDataSave(jumpData:Int, breakData:Int, collisionData:Int) {
        defaults.set(jumpData, forKey: "JumpData")
        defaults.set(breakData, forKey: "BreakData")
        defaults.set(collisionData, forKey: "CollisionData")
    }
    
}


extension UserDefaults {
    // MARK: UserDefault Object 변환사용
    func setObjectToUserDefault<T: Codable>(_ data: T?, forKey defaultName:String) {
        let encoded = try? JSONEncoder().encode(data)
        set(encoded,  forKey: defaultName)
    }
    
    func setUserDefaultToObject<T: Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
    }
}
