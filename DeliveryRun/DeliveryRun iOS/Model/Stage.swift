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
    var star: Int {
        get {
            if targetRecord - 15 >= myRecord { return 3 }
            else if targetRecord >= myRecord { return 2 }
            else if targetRecord + 15 >= myRecord { return 1 }
            return 0
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

