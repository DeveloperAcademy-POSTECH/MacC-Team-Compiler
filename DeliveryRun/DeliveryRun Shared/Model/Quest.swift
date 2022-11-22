//
//  Quest.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/21.
//

import Foundation
import UIKit


class Quest {
    let title: String
    let subTitle: String
    let image:UIImage
    let reward: String
    let totalNumber: Int
    var nowNumber: Int
    var isClear: Bool
    
    init(title: String, subTitle: String, image:UIImage, reward: String, totalNumber: Int, nowNumber: Int, isClear: Bool) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.reward = reward
        self.totalNumber = totalNumber
        self.nowNumber = nowNumber
        self.isClear = isClear
    }
}
