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
        UserDefaultData.findPath()
        // Sound Value
        self.backgroundMusic = UserDefaults.standard.bool(forKey: "BackgroundMusic")
        self.soundEffect = UserDefaults.standard.bool(forKey: "SoundEffect")
        
        // Collection & Skin Value
        self.mySkin = UserDefaults.standard.string(forKey: "MyPlayerSkin") ?? "default"
        if let mySkinList = UserDefaults.standard.array(forKey: "MySkins") {
            self.mySkins = mySkinList as! [String]
        } else {
            self.mySkins = ["default"]
        }
        
        // Chapter & Stage Value
        self.chapterNumber = UserDefaults.standard.integer(forKey: "ChapterNumber")
        self.stageNumber = UserDefaults.standard.integer(forKey: "StageNumber")
        
        self.clearStage = UserDefaults.standard.array(forKey: "ClearStage") as? [[Bool]] ?? [[true,true,true,true,true,false,false,false,false,false,false,false,false,false,false],
                                                                                             [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false]]
        
        self.recordStage = UserDefaults.standard.array(forKey:"RecordStage") as? [[Float]] ?? [[0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00]]
        
        // InGameData
        self.jumpData = UserDefaults.standard.integer(forKey: "JumpData")
        self.breakData = UserDefaults.standard.integer(forKey: "BreakData")
        self.collisionData = UserDefaults.standard.integer(forKey: "CollisionData")
        
        // Quest Value
        self.jumpQuestDone = UserDefaults.standard.bool(forKey: "JumpQuestDone")
        self.breakQuestDone = UserDefaults.standard.bool(forKey: "BreakQuestDone")
        self.collisionQuestDone = UserDefaults.standard.bool(forKey: "CollisionQuestDone")
        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jumpSkin", totalNumber: 5, nowNumber: self.jumpData, isClear: self.jumpQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "JumpQuest")
        let quest2 = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "breakSkin", totalNumber: 5, nowNumber: self.breakData, isClear: self.breakQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest2, forKey: "BreakQuest")
        let quest3 = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collisionSkin", totalNumber: 50, nowNumber: self.collisionData, isClear: self.collisionQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest3, forKey: "CollisionQuest")
        
    }
    
    
    // Sound Value
    var backgroundMusic:Bool
    var soundEffect:Bool
    
    func setSetting(backgroundMusic:Bool, gameSound:Bool) {
        self.backgroundMusic = backgroundMusic
        self.soundEffect = gameSound
        defaults.set(self.backgroundMusic, forKey: "BackgroundMusic")
        defaults.set(self.soundEffect, forKey: "SoundEffect")
    }
    
    // Collection & Skin Value
    var mySkins:[String]
    var mySkin:String
    
    func setSkin(skinName:String) {
        self.mySkin = skinName
        defaults.set(mySkin, forKey: "MySkin")
    }
    
    // Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    var jumpQuestDone:Bool
    var breakQuestDone:Bool
    var collisionQuestDone:Bool
    
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
    
    // Chapter & Stage
    
    
    private var chapterNumber: Int
    private var stageNumber:Int
    
    func getChapterNumber() -> Int {
        self.chapterNumber
    }
    
    func getStageNumber() -> Int {
        self.stageNumber
    }
    
    func setChapterNumber(chapterNumber:Int) {
        self.chapterNumber = chapterNumber
        defaults.set(self.chapterNumber, forKey: "ChapterNumber")
    }
    
    func setStageNumber(stageNumber:Int) {
        self.stageNumber = stageNumber
        defaults.set(self.stageNumber, forKey: "StageNumber")
    }
    
    
    let targetRecord: [[Float]] = [
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00]
    ]
    private var clearStage:[[Bool]]
    
    private var recordStage:[[Float]]
    
    

    func getTargetRecord(chapterNumber:Int, stageNumber:Int) -> Float {
        self.targetRecord[chapterNumber - 1][stageNumber - 1]
    }
    
    func getClearStage(chapterNumber:Int, stageNumber:Int) -> Bool {
        self.clearStage[chapterNumber - 1][stageNumber - 1]
    }
    
    func getRecordStage(chapterNumber:Int, stageNumber: Int) -> Float {
        self.recordStage[chapterNumber - 1][stageNumber - 1]
    }
    
    func setClearStage() {
        if !self.clearStage[self.chapterNumber - 1][self.stageNumber - 1] {
            self.clearStage[self.chapterNumber - 1][self.stageNumber] = true
            defaults.set(self.clearStage, forKey:"ClearStage")
        } else {
            print("This Stage Already Done")
        }
    }
    func setRecordStage(timeRecord:Float) {
        if self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] != 0.00 && self.recordStage[self.chapterNumber - 1][self.stageNumber] < timeRecord {
            self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] = timeRecord
            defaults.set(self.recordStage, forKey: "RecordStage")
        } else {
            print("Not Override Record")
        }
        
    }
    
    func saveStageData(chpaterNumber:Int, stageNumber:Int, timeRecord:Float) {
        setClearStage()
        setRecordStage(timeRecord:timeRecord)
    }
    
    
    
    func saveUserData(jumpData:Int, breakData:Int, collisionData:Int) {
        self.jumpData = jumpData
        defaults.set(self.jumpData, forKey: "JumpData")
        self.breakData = breakData
        defaults.set(self.breakData, forKey: "BreakData")
        self.collisionData = collisionData
        defaults.set(self.collisionData, forKey: "CollisionData")
        
        let quest1 = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jumpSkin", totalNumber: 50, nowNumber: jumpData,isClear: self.jumpQuestDone)
        UserDefaults.standard.setObjectToUserDefault(quest1, forKey: "Quest1")
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



