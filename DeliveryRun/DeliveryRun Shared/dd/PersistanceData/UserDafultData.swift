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
        
        
        // Stage Setting
//        self.stageOneRecord = UserDefaults.standard.double(forKey: "StageOneRecord")
//        self.stageOneDone = UserDefaults.standard.bool(forKey: "StageOneDone")
//
//        self.stageTwoRecord = UserDefaults.standard.double(forKey: "StageTwoRecord")
//        self.stageTwoDone = UserDefaults.standard.bool(forKey: "StageTwoDone")
//
//        self.stageThreeRecord = UserDefaults.standard.double(forKey: "StageThreeRecord")
//        self.stageThreeDone = UserDefaults.standard.bool(forKey: "StageThreeDone")
//
//        self.stageFourRecord = UserDefaults.standard.double(forKey: "StageFourRecord")
//        self.stageFourDone = UserDefaults.standard.bool(forKey: "StageFourDone")
//
//        self.stageFiveRecord = UserDefaults.standard.double(forKey: "StageFiveRecord")
//        self.stageFiveDone = UserDefaults.standard.bool(forKey: "StageFiveDone")
        
        

//        let stage1 = Stage(name: "스테이지 1", image: "stage1", targetRecord: 60.00, myRecord: self.stageOneRecord , isLock: false)
//        UserDefaults.standard.setObjectToUserDefault(stage1, forKey: "StageOne")
//
//        let stage2 = Stage(name: "스테이지 2", image: "stage2", targetRecord: 60.00, myRecord: self.stageTwoRecord, isLock: !self.stageOneDone)
//        UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "StageTwo")
//
//        let stage3 = Stage(name: "스테이지 3", image: "stage3", targetRecord: 60.00, myRecord: self.stageThreeRecord, isLock: !self.stageTwoDone)
//        UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "StageThree")
//
//        let stage4 = Stage(name: "스테이지 4", image: "stage4", targetRecord: 60.00, myRecord: self.stageFourRecord, isLock: !self.stageThreeDone)
//        UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "StageFour")
//
//        let stage5 = Stage(name: "스테이지 5", image: "stage5", targetRecord: 60.00, myRecord: self.stageFiveRecord, isLock: !self.stageFourDone)
//        UserDefaults.standard.setObjectToUserDefault(stage5, forKey: "StageFive")
        
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
    
    var chapterNumber: Int
    var stageNumber:Int
    var clearChpater:[String: [Bool]] {
        if let clearChpater = UserDefaults.standard.dictionary(forKey: "ClearChapter") {
            return clearChpater as! [String: [Bool]]
        } else {
            return ["Chapter1": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                    "Chapter2": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                    "Chapter3": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                    "Chapter4": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                    "Chapter5": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
                    "Chapter6": [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false],
            ]
        }
    }
    var recordChpater:[String: [Float]] {
        if let recordChapter = UserDefaults.standard.dictionary(forKey: "RecordChapter") {
            return recordChapter as! [String: [Float]]
        } else {
            return ["Chpater1": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
                    "Chpater2": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
                    "Chpater3": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
                    "Chpater4": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
                    "Chpater5": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00],
                    "Chpater6": [0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00]
            ]
        }
    }
    
    func setChapterAndStage(chapterNumber:Int, stageNumber:Int) {
        self.chapterNumber = chapterNumber
        self.stageNumber = stageNumber
        defaults.set(self.chapterNumber, forKey: "ChapterNumber")
        defaults.set(self.stageNumber, forKey: "StageNumber")
    }
    
    
    
    
    func gameCompleted (chapterNumber:Int, stageNumber:Int, timeRecord:Float) {
//        if stageNumber == 1 {
//            if self.stageOneRecord == 0.0 {
//                self.stageOneRecord = timeRecord
//                defaults.set(timeRecord, forKey: "StageOneRecord")
//                let stage1 = Stage(name: "스테이지 1", image: "stage1", targetRecord: 60.00, myRecord: self.stageOneRecord , isLock: false)
//                UserDefaults.standard.setObjectToUserDefault(stage1, forKey: "StageOne")
//            } else {
//                if timeRecord < self.stageOneRecord {
//                    self.stageOneRecord = timeRecord
//                    defaults.set(timeRecord, forKey: "StageOneRecord")
//                }
//            }
//            self.stageOneDone = true
//            defaults.set(self.stageOneDone, forKey: "StageOneDone")
//            let stage2 = Stage(name: "스테이지 1", image: "stage2", targetRecord: 60.00, myRecord: self.stageTwoRecord , isLock: false)
//            UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "StageTwo")
//        } else if stageNumber == 2 {
//            if self.stageTwoRecord == 0.0 {
//                self.stageTwoRecord = timeRecord
//                defaults.set(timeRecord, forKey: "StageTwoRecord")
//                let stage2 = Stage(name: "스테이지 2", image: "stage2", targetRecord: 60.00, myRecord: self.stageTwoRecord , isLock: false)
//                UserDefaults.standard.setObjectToUserDefault(stage2, forKey: "StageTwo")
//            } else {
//                if timeRecord < self.stageTwoRecord {
//                    self.stageTwoRecord = timeRecord
//                    defaults.set(timeRecord, forKey: "StageTwoRecord")
//                }
//            }
//            self.stageTwoDone = true
//            defaults.set(self.stageTwoDone, forKey: "StageTwoDone")
//            let stage3 = Stage(name: "스테이지 3", image: "stage3", targetRecord: 60.00, myRecord: self.stageThreeRecord , isLock: false)
//            UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "StageThree")
//
//        } else if stageNumber == 3 {
//            if self.stageThreeRecord == 0.0 {
//                self.stageThreeRecord = timeRecord
//                defaults.set(timeRecord, forKey: "StageThreeRecord")
//                let stage3 = Stage(name: "스테이지 3", image: "stage3", targetRecord: 60.00, myRecord: self.stageThreeRecord , isLock: false)
//                UserDefaults.standard.setObjectToUserDefault(stage3, forKey: "StageThree")
//            } else {
//                if timeRecord < self.stageThreeRecord {
//                    self.stageThreeRecord = timeRecord
//                    defaults.set(timeRecord, forKey: "StageThreeRecord")
//                }
//            }
//            self.stageThreeDone = true
//            defaults.set(self.stageThreeDone, forKey: "StageThreeDone")
//            let stage4 = Stage(name: "스테이지 4", image: "stage4", targetRecord: 60.00, myRecord: self.stageFourRecord , isLock: false)
//            UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "StageFour")
//        } else if stageNumber == 4 {
//            if self.stageFourRecord == 0.0 {
//                self.stageFourRecord = timeRecord
//                defaults.set(timeRecord, forKey: "StageFourRecord")
//                let stage4 = Stage(name: "스테이지 4", image: "stage4", targetRecord: 60.00, myRecord: self.stageFourRecord , isLock: false)
//                UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "StaeFour")
//            } else {
//                if timeRecord < self.stageFourRecord {
//                    self.stageThreeRecord = timeRecord
//                    defaults.set(timeRecord, forKey: "StageFourRecord")
//                }
//            }
//            self.stageFourDone = true
//            defaults.set(self.stageFourDone, forKey: "StageFourDone")
//            let stage5 = Stage(name: "스테이지 5", image: "stage5", targetRecord: 60.00, myRecord: self.stageFiveRecord , isLock: false)
//            UserDefaults.standard.setObjectToUserDefault(stage5, forKey: "StageFive")
//        } else if stageNumber == 5 {
//            if self.stageFiveRecord == 0.0 {
//                self.stageFiveRecord = timeRecord
//                defaults.set(timeRecord, forKey: "StageFiveRecord")
//                let stage4 = Stage(name: "스테이지 5", image: "stage5", targetRecord: 60.00, myRecord: self.stageFiveRecord , isLock: false)
//                UserDefaults.standard.setObjectToUserDefault(stage4, forKey: "StageFive")
//            } else {
//                if timeRecord < self.stageFourRecord {
//                    self.stageThreeRecord = timeRecord
//                    defaults.set(timeRecord, forKey: "StageFiveRecord")
//                }
//            }
//            self.stageFiveDone = true
//            defaults.set(self.stageFiveDone, forKey: "StageFiveDone")
//            print("All Stage Clear")
//
//        } else {
//            print("Out Stage")
//        }
    }
    
    // Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    
    
    func endGameSaveData(jumpData:Int, breakData:Int, collisionData:Int, timeRecord:Float, stageNumber:Int) {
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
        
        gameCompleted(chapterNumber: 1, stageNumber: stageNumber, timeRecord: timeRecord)
        
        
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



