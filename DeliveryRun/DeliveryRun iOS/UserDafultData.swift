//
//  UserDafultData.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/29.



import Foundation


class UserDefaultData {
    
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
        self.playStageNumber = UserDefaults.standard.integer(forKey: "PlayStageNumber")
        self.backgroundMusic = UserDefaults.standard.bool(forKey: "BackgroundMusic")
        self.gameSound = UserDefaults.standard.bool(forKey: "GameSound")
        self.mySkin = UserDefaults.standard.string(forKey: "MyPlayerSkin") ?? "default"
        

        if let mySkinList = UserDefaults.standard.array(forKey: "MySkins") {
            self.mySkins = mySkinList as! [String]
        } else {
            self.mySkins = ["default"]
        }
        
        self.jumpData = UserDefaults.standard.integer(forKey: "JumpData")
        self.breakData = UserDefaults.standard.integer(forKey: "BreakData")
        self.collisionData = UserDefaults.standard.integer(forKey: "CollisionData")
        
        // Quest Setting
        
        self.jumpQuestDone = UserDefaults.standard.bool(forKey: "JumpQuestDone")
        self.breakQuestDone = UserDefaults.standard.bool(forKey: "BreakQuestDone")
        self.collisionQuestDone = UserDefaults.standard.bool(forKey: "CollisionQuestDone")
        
        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jumpSkin", totalNumber: 5, nowNumber: self.jumpData, isClear: self.jumpQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "JumpQuest")
        let quest2 = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "breakSkin", totalNumber: 5, nowNumber: self.breakData, isClear: self.breakQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest2, forKey: "BreakQuest")
        let quest3 = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collisionSkin", totalNumber: 50, nowNumber: self.collisionData, isClear: self.collisionQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest3, forKey: "CollisionQuest")
        
        
        // Stage Setting
        self.stageOneRecord = UserDefaults.standard.double(forKey: "StageOneRecord")
        self.stageOneDone = UserDefaults.standard.bool(forKey: "StageOneDone")
        
        self.stageTwoRecord = UserDefaults.standard.double(forKey: "StageTwoRecord")
        self.stageTwoDone = UserDefaults.standard.bool(forKey: "StageTwoDone")
        
        self.stageThreeRecord = UserDefaults.standard.double(forKey: "StageThreeRecord")
        self.stageThreeDone = UserDefaults.standard.bool(forKey: "StageThreeDone")
        
        self.stageFourRecord = UserDefaults.standard.double(forKey: "StageFourRecord")
        self.stageFourDone = UserDefaults.standard.bool(forKey: "StageFourDone")
        
        self.stageFiveRecord = UserDefaults.standard.double(forKey: "StageFiveRecord")
        self.stageFiveDone = UserDefaults.standard.bool(forKey: "StageFiveDone")
        

        let stage1 = Stage(name: "스테이지 1", image: "star0", targetRecord: 50.0, myRecord: self.stageOneRecord, isLock: false)
        UserDefaults.standard.setObjectToUserDefault(stage1, forKey: "StageOne")

        let stage2 = Stage(name: "스테이지 2", image: "star0", targetRecord: 60.0, myRecord: self.stageTwoRecord, isLock: !self.stageOneDone)
        UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "StageTwo")

        let stage3 = Stage(name: "스테이지 3", image: "star0", targetRecord: 70.0, myRecord: self.stageThreeRecord, isLock: !self.stageTwoDone)
        UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "StageThree")

        let stage4 = Stage(name: "스테이지 4", image: "star0", targetRecord: 80.0, myRecord: self.stageFourRecord, isLock: !self.stageThreeDone)
        UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "StageFour")

        let stage5 = Stage(name: "스테이지 5", image: "star0", targetRecord: 90.0, myRecord: self.stageFiveRecord, isLock: !self.stageFourDone)
        UserDefaults.standard.setObjectToUserDefault(stage5, forKey: "StageFive")
        
        
         
        
    }
    
    // Setting
    var backgroundMusic:Bool
    var gameSound:Bool
    
    
    func setSetting(backgroundMusic:Bool, gameSound:Bool) {
        defaults.set(self.backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(self.gameSound, forKey: "GameSound")
        self.backgroundMusic = backgroundMusic
        self.gameSound = gameSound
    }
    
    
    

    // PlayerSkin
    var skins:[String] = ["default", "jumpSkin", "breakSkin", "collisionSkin"]
    var mySkins:[String]
    var mySkin:String
    
    
    func setSkin(skinName:String) {
        self.mySkin = skinName
        defaults.set(mySkin, forKey: "MySkin")
    }
    
    var jumpQuestDone:Bool = false
    var breakQuestDone:Bool = false
    var collisionQuestDone:Bool = false
    
    func jumpQuestCompleted() {
        self.jumpQuestDone = true
        defaults.set(jumpQuestDone, forKey: "JumpQuestDone")
        mySkins.append("jumpSkin")
        defaults.set(mySkins, forKey: "MySkins")
    }
    
    func breakQuestCompleted() {
        self.breakQuestDone = true
        defaults.set(self.breakQuestDone, forKey: "BreakQuestDone")
        mySkins.append("breakSkin")
        defaults.set(mySkins, forKey: "MySkins")
    }
    
    func collisionQuestCompleted() {
        self.collisionQuestDone = true
        defaults.set(self.collisionQuestDone, forKey: "CollisionQuestDone")
        mySkins.append("collisionSkin")
        defaults.set(mySkins, forKey: "MySkins")
    }
    
    
    // Stage
    var stageOneRecord:Double = 0.00
    var stageTwoRecord:Double = 0.00
    var stageThreeRecord:Double = 0.00
    var stageFourRecord:Double = 0.00
    var stageFiveRecord:Double = 0.00
    
    var stageOneDone:Bool
    var stageTwoDone:Bool
    var stageThreeDone:Bool
    var stageFourDone:Bool
    var stageFiveDone:Bool
    
    // StageNumber
    var playStageNumber:Int
    
    func setStageNumber(stageNumber:Int) {
        
    }
    
    
    func stageOneCompleted(timeRecord:Double) {
        
        if timeRecord < self.stageOneRecord && self.stageOneRecord != 0.00  {
            self.stageOneRecord = timeRecord
            defaults.set(timeRecord, forKey: "StageOneRecord")
        }
        self.stageOneDone = true
        defaults.set(self.stageOneDone, forKey: "StageOneDone")
    }
    
    func secondStageCompleted(timeRecord:Double) {
        if timeRecord < self.stageTwoRecord && self.stageTwoRecord != 0.00  {
            self.stageTwoRecord = timeRecord
            defaults.set(self.stageTwoRecord, forKey: "StageTwoRecord")
        }
        self.stageTwoDone = true
        defaults.set(self.stageTwoDone = true, forKey: "StageTwoDone")
    }
    func thirdStageCompleted(timeRecord:Double) {
        if timeRecord < self.stageThreeRecord && self.stageThreeRecord != 0.00  {
            self.stageThreeRecord = timeRecord
            defaults.set(self.stageThreeRecord, forKey: "StageThreeRecord")
        }
        self.stageThreeDone = true
        defaults.set(self.stageThreeDone, forKey: "StageThreeDone")
    }
    func fourStageCompleted(timeRecord:Double) {
        if timeRecord < self.stageFourRecord && self.stageFourRecord != 0.00  {
            self.stageFourRecord = timeRecord
            defaults.set(timeRecord, forKey: "StageFourRecord")
        }
        self.stageFourDone = true
        defaults.set(self.stageFourDone, forKey: "StageFourDone")
    }
    func fiveStageCompleted(timeRecord:Double) {
        if timeRecord < self.stageFiveRecord && self.stageFiveRecord != 0.00  {
            self.stageFiveRecord = timeRecord
            defaults.set(timeRecord, forKey: "StageFiveRecord")
        }
        self.stageFiveDone = false
        defaults.set(self.stageFiveDone, forKey: "StageFiveDone")
    }
    
    // Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    
    func endGameSaveData(jumpData:Int, breakData:Int, collisionData:Int, timeRecord:Double, playStageNumber:Int) {
        self.jumpData = jumpData
        defaults.set(self.jumpData, forKey: "JumpData")
        self.breakData = breakData
        defaults.set(self.breakData, forKey: "BreakData")
        self.collisionData = collisionData
        defaults.set(self.collisionData, forKey: "CollisionData")
        
        
        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jumpSkin", totalNumber: 50, nowNumber: jumpData,isClear: self.jumpQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "Quest1")
        
        self.breakQuestDone = UserDefaults.standard.bool(forKey: "SecondQuestIsClear")
        let quest2 = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "breakSkin", totalNumber: 20, nowNumber: breakData, isClear: self.breakQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest2, forKey: "Quest2")
        
        self.collisionQuestDone = UserDefaults.standard.bool(forKey: "ThirdQuestIsClear")
        let quest3 = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collisionSkin", totalNumber: 50, nowNumber: collisionData, isClear: self.collisionQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest3, forKey: "Quest3")
        
        
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



