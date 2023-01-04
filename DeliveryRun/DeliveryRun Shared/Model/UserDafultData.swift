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
        self.backgroundMusic = defaults.bool(forKey: "BackgroundMusic")
        self.soundEffect = defaults.bool(forKey: "SoundEffect")
        
        
        // Chapter & Stage Value
        self.chapterNumber = defaults.integer(forKey: "ChapterNumber")
        self.stageNumber = defaults.integer(forKey: "StageNumber")
        
        self.clearStage = defaults.array(forKey: "ClearStage") as? [[Bool]] ?? [[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                                                                                             [true,false,false,false,false,false,false,false,false,false,false,false,false,false,false]]
        
        self.recordStage = defaults.array(forKey:"RecordStage") as? [[Double]] ?? [[0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
            [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00]]
        
        // InGameData
        self.jumpData = defaults.integer(forKey: "JumpData")
        self.breakData = defaults.integer(forKey: "BreakData")
        self.collisionData = defaults.integer(forKey: "CollisionData")
        
        
        // Collection & Skin Value
        self.nowSkin = defaults.string(forKey: "NowSkin") ?? "default"
        if let mySkinList = defaults.array(forKey: "SkinList") {
            self.skinList = mySkinList as! [String]
        } else {
            self.skinList = ["default"]
        }

        // Quest Value
        if let loadJumpQuest = defaults.setUserDefaultToObject(dataType: Quest.self, key: "JumpQuest") {
            self.jumpQuest = loadJumpQuest
        } else {
            self.jumpQuest = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jump", totalNumber: 1, nowNumber: 0, isClear: false )
            defaults.setObjectToUserDefault(self.jumpQuest, forKey: "JumpQuest")
        }
        
        if let loadBreakQuest = defaults.setUserDefaultToObject(dataType: Quest.self, key: "BreakQuest") {
            self.breakQuest = loadBreakQuest
        } else {
            self.breakQuest = Quest(title: "하남자특", subTitle: "총 브레이크 사용 횟수 50회를 달성하세요 .", imageURl: "break", totalNumber: 1, nowNumber: 0, isClear: false)
            defaults.setObjectToUserDefault(self.breakQuest, forKey: "BreakQuest")
        }
        
        if let loadCollisionQuest = defaults.setUserDefaultToObject(dataType: Quest.self, key: "CollisionQuest") {
            self.collisionQuest = loadCollisionQuest
        } else {
            self.collisionQuest = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collision", totalNumber: 1, nowNumber: 0, isClear: false)
            defaults.setObjectToUserDefault(collisionQuest, forKey: "CollisionQuest")
        }
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
    var nowSkin:String
    var skinList:[String]
    
    func setSkin(skinName:String) {
        self.nowSkin = skinName
        defaults.set(nowSkin, forKey: "NowSkin")
    }
    
    func getSkin(skinName:String) {
        self.skinList.append(skinName)
        defaults.set(skinList, forKey: "SkinList")
    }
    
    // Player
    
    let defaultPlayer = Player(name: "default", velocity: 7, jump: 7, special: false)
    let jumpPlayer = Player(name: "jump", velocity: 7, jump: 9, special: false)
    let breakPlayer = Player(name: "break", velocity: 9, jump: 7, special: false)
    let collisionPlayer = Player(name: "collision", velocity: 7, jump: 7, special: true)
    
    
    // Quest & Tracking Data
    var jumpQuest:Quest
    var breakQuest:Quest
    var collisionQuest:Quest
    
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    func jumpQuestCompleted() {
        self.jumpQuest = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jump", totalNumber: 1, nowNumber: 1, isClear: true )
        defaults.setObjectToUserDefault(self.jumpQuest, forKey: "JumpQuest")
        getSkin(skinName: "jump")
    }
    
    func breakQuestCompleted() {
        self.breakQuest = Quest(title: "하남자특", subTitle: "총 브레이크 사용 횟수 50회를 달성하세요 .", imageURl: "break", totalNumber: 1, nowNumber: 1, isClear: true)
        defaults.setObjectToUserDefault(self.breakQuest, forKey: "BreakQuest")
        getSkin(skinName: "break")
    }
    
    func collisionQuestCompleted() {
        self.collisionQuest = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collision", totalNumber: 1, nowNumber: 1, isClear: true)
        defaults.setObjectToUserDefault(collisionQuest, forKey: "CollisionQuest")
        getSkin(skinName: "collision")
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
    
    
    let targetRecord: [[Double]] = [
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00],
        [10.00, 20.00, 30.00, 40.00, 50.00, 60.00, 70.00, 80.00, 90.00, 100.00, 110.00, 120.00, 130.00, 140.00, 150.00]
    ]
    private var clearStage:[[Bool]]
    
    private var recordStage:[[Double]]
    
    

    func getTargetRecord(chapterNumber:Int, stageNumber:Int) -> Double {
        self.targetRecord[chapterNumber - 1][stageNumber - 1]
    }
    
    func getClearStage(chapterNumber:Int, stageNumber:Int) -> Bool {
        self.clearStage[chapterNumber - 1][stageNumber - 1]
    }
    
    func getRecordStage(chapterNumber:Int, stageNumber: Int) -> Double {
        self.recordStage[chapterNumber - 1][stageNumber - 1]
    }
    
    func setClearStage() {
        if self.clearStage[self.chapterNumber - 1][self.stageNumber - 1] {
            self.clearStage[self.chapterNumber - 1][self.stageNumber] = true
            defaults.set(self.clearStage, forKey:"ClearStage")
        } else {
            print("This Stage Already Done")
        }
    }
    
    func setRecordStage(timeRecord: Double) {
        if self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] == 0.0 {
            self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] = timeRecord
            defaults.set(self.recordStage, forKey: "RecordStage")
        } else if self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] > timeRecord {
            self.recordStage[self.chapterNumber - 1][self.stageNumber - 1] = timeRecord
            defaults.set(self.recordStage, forKey: "RecordStage")
        } else {
            print("Not Override Record")
        }
        
    }
    
    func saveStageData(chpaterNumber:Int, stageNumber:Int, timeRecord:Double) {
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
        
        let jumpQuest = Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", imageURl: "jump", totalNumber: 50, nowNumber: jumpData, isClear: false)
        defaults.setObjectToUserDefault(jumpQuest, forKey: "JumpQuest")
        let breakQuest = Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", imageURl: "break", totalNumber: 20, nowNumber: breakData, isClear: false)
        defaults.setObjectToUserDefault(breakQuest, forKey: "BreakQuest")
        let collisionQuest = Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", imageURl: "collision", totalNumber: 50, nowNumber: collisionData, isClear: false)
        defaults.setObjectToUserDefault(collisionQuest, forKey: "CollisionQuest")
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



