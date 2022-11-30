//
//  Stage.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/22.
//

import UIKit
import Foundation

class Stage: Codable{
    
    let name: String
    let image: String
    let targetRecord: Double
    var myRecord: Double
    var star: String {
        get {
            if targetRecord + 15 < myRecord {
                return "resultStar1"
            }
            if targetRecord - 15 > myRecord {
                return "resultStar3"
            }
            return "resultStar2"
        }
    }
    var isLock: Bool
    
    init(name: String, image: String, targetRecord: Double, myRecord:Double,isLock: Bool) {
        self.name = name
        self.image = image
        self.targetRecord = targetRecord
        self.myRecord = myRecord
        self.isLock = isLock
    }
}

