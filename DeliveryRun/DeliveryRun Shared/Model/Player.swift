//
//  Player.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/24.
//

import Foundation
import UIKit

class Player {
    let speed:Int
    let jump:Int
    let special:Bool
    let iamge:UIImage
    
    init(speed: Int, jump: Int, special: Bool, iamge: UIImage) {
        self.speed = speed
        self.jump = jump
        self.special = special
        self.iamge = iamge
    }
}
