//
//  Quest.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/21.
//

import Foundation
import UIKit

class Quest: Codable {
    let title: String
    let subTitle: String
    let imageURL:String
    let totalNumber: Int
    var nowNumber: Int
    var isClear: Bool
    
    init(title: String, subTitle: String, imageURl:String, totalNumber: Int, nowNumber: Int, isClear: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.imageURL = imageURl
        self.totalNumber = totalNumber
        self.nowNumber = nowNumber
        self.isClear = isClear
    }
}

