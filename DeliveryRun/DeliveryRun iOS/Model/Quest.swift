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

let quests: [Quest] = [
    Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", image:UIImage(named: "collection1")!, reward: "Bike", totalNumber: 50, nowNumber: 10, isClear: false),
    Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", image:UIImage(named: "collection2")!, reward: "Scooter", totalNumber: 20, nowNumber: 20, isClear: true),
    Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", image:UIImage(named: "collection3")!, reward: "Car", totalNumber: 50, nowNumber: 10, isClear: false),
]
