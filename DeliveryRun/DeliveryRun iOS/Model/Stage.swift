//
//  Stage.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/22.
//

import UIKit
import Foundation

struct Stage {
    
    let userDefaultData = UserDefaultData()
    
    let stageName: String
    let foodImageName: String
    let targetRecord: Double
    var myRecord: Double
    var star: Int
    var isLock: Bool
    
    init(stageName: String, foodImageName: String, targetRecord: Double, star: Int, isLock: Bool) {
        self.stageName = stageName
        self.foodImageName = foodImageName
        self.targetRecord = targetRecord
        self.myRecord = userDefaultData.myRecord
        self.star = star
        self.isLock = isLock
    }
}

let stageList: [Stage] = [
    Stage(stageName: "스테이지 1", foodImageName: "star0", targetRecord: 90.0, star: 3, isLock: false),
    Stage(stageName: "스테이지 2", foodImageName: "", targetRecord: 90.0, star: 2, isLock: true),
    Stage(stageName: "스테이지 3", foodImageName: "", targetRecord: 90.0, star: 1, isLock: true),
    Stage(stageName: "스테이지 4", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 5", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 6", foodImageName: "", targetRecord: 90.0,  star: 0, isLock: false),
    Stage(stageName: "스테이지 7", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 8", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 9", foodImageName: "", targetRecord: 90.0,  star: 0, isLock: false),
    Stage(stageName: "스테이지 10", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 11", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 12", foodImageName: "", targetRecord: 90.0, star: 0, isLock: false),
    Stage(stageName: "스테이지 13", foodImageName: "", targetRecord: 90.0,  star: 0, isLock: false),
    Stage(stageName: "스테이지 14", foodImageName: "", targetRecord: 90.0,  star: 0, isLock: false),
    Stage(stageName: "스테이지 15", foodImageName: "", targetRecord: 90.0,  star: 0, isLock: false)
]
