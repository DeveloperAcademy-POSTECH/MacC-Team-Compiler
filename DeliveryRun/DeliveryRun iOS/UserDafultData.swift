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
        self.inGameSound = UserDefaults.standard.bool(forKey: "InGameSound")
        self.mySkin = UserDefaults.standard.string(forKey: "MyPlayerSkin") ?? "default"
        if let mySkinList = UserDefaults.standard.array(forKey: "MySkinList") {
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
         
        
    }
    
    // Setting
    var backgroundMusic:Bool
    var inGameSound:Bool
    
    
    func setSetting(backgroundMusic:Bool, inGameSound:Bool) {
        defaults.set(backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(inGameSound, forKey: "InGameMusic")
    }
    
    func getSetting() {
        self.backgroundMusic = defaults.bool(forKey: "BackgroundMusic")
        self.inGameSound = defaults.bool(forKey: "InGameMusic")
    }
    
    

    // PlayerSkin
    var skins:[String]
    var mySkins:[String]
    var mySkin:String
    
    
    func setSkin(skinName:String) {
        defaults.set(mySkin, forKey: "MySkin")
    }
    
    func getSkin() {
        self.mySkin = defaults.string(forKey: "MySkin")!
    }
    
    var jumpQuestDone:Bool = false
    var breakQuestDone:Bool = false
    var collisionQuestDone:Bool = false
    
    func jumpQuestCompleted() {
        self.jumpQuestDone = true
        defaults.set(jumpQuestDone, forKey: "JumpQuestDone")
        mySkins.append("jumpSkin")
    }
    
    func breakQuestCompleted() {
        self.breakQuestDone = true
        defaults.set(self.breakQuestDone, forKey: "BreakQuestDone")
        mySkins.append("breakSkin")
    }
    
    func collisionQuestCompleted() {
        self.collisionQuestDone = true
        defaults.set(self.collisionQuestDone, forKey: "CollisionQuestDone")
        mySkins.append("collisionSkin")
    }
    
    
    // Stage
    var stageOneRecord:Double
    var stageTwoRecord:Double
    var stageThreeRecord:Double
    var stageFourRecord:Double
    var stageFiveRecord:Double
    
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
        self.stageOneRecord = timeRecord
        defaults.set(timeRecord, forKey: "StageOneRecord")
        self.stageOneDone = true
        defaults.set(self.stageOneDone, forKey: "StageOneDone")
    }
    
    func secondStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "StageTwoRecord")
        self.stageTwoDone = true
        defaults.set(self.stageTwoDone = true, forKey: "SecondStageClear")
    }
    func thirdStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "StageThreeRecord")
        self.stageThreeDone = true
        defaults.set(self.stageThreeDone, forKey: "ThirdStageClear")
    }
    func fourStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "FourStageClear")
        self.stageFourDone = true
        defaults.set(self.stageFourDone, forKey: "FourStageClear")
    }
    func fiveStageCompleted(timeRecord:Double) {
        defaults.set(timeRecord, forKey: "Record5")
        self.stageFiveDone = false
        defaults.set(self.stageFiveDone, forKey: "FiveStageClear")
    }
    
    // Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    func endGameSaveData(jumpData:Int, breakData:Int, collisionData:Int, timeRecord:Double, playStageNumber:Int) {
        defaults.set(jumpData, forKey: "JumpData")
        defaults.set(breakData, forKey: "BreakData")
        defaults.set(collisionData, forKey: "CollisionData")
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



//        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jumpSkin", totalNumber: 50, nowNumber: self.jumpData, isClear: self.jumpQuestDone)
//        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "Quest1")
//
//        self.breakQuestDone = UserDefaults.standard.bool(forKey: "SecondQuestIsClear")
//        let quest2 = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "breakSkin", totalNumber: 20, nowNumber: self.breakData, isClear: self.breakQuestDone)
//        UserDefaults.standard.setObjectToUserDefault(quest2, forKey: "Quest2")
//
//        self.collisionQuestDone = UserDefaults.standard.bool(forKey: "ThirdQuestIsClear")
//        let quest3 = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collisionSkin", totalNumber: 50, nowNumber: self.collisionData, isClear: self.collisionQuestDone)
//        UserDefaults.standard.setObjectToUserDefault(quest3, forKey: "Quest3")

        
        //        let stage1 = Stage(name: "스테이지 1", image: "star0", targetRecord: 50.0, myRecord: self.stageOneRecord, isLock: false)
        //        self.firstStage = stage1
        //        UserDefaults.standard.setObjectToUserDefault(stage1, forKey: "Stage1")
        //
        //        let stage2 = Stage(name: "스테이지 2", image: "star0", targetRecord: 60.0, myRecord: self.stageTwoRecord, isLock: !self.stageOneDone)
        //        self.secondStage = stage2
        //        UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "Stage2")
        //
        //        let stage3 = Stage(name: "스테이지 3", image: "star0", targetRecord: 70.0, myRecord: self.stageThreeRecord, isLock: !self.stageTwoDone)
        //        self.thirdStage = stage3
        //        UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "Stage3")
        //
        //        let stage4 = Stage(name: "스테이지 4", image: "star0", targetRecord: 80.0, myRecord: self.stageFourRecord, isLock: !self.stageThreeDone)
        //        self.fourStage = stage4
        //        UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "Stage4")
        //
        //        let stage5 = Stage(name: "스테이지 5", image: "star0", targetRecord: 90.0, myRecord: self.stageFiveRecord, isLock: !self.stageFourDone)
        //        self.fiveStage = stage5
        //        UserDefaults.standard.setObjectToUserDefault(stage5, forKey: "Stage5")
