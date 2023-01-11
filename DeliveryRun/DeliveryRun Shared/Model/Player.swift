//
//  Player.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/30.
//

import Foundation

class Player: Codable {
    var name: String
    var velocity: Float
    var jump: Float
    var special: Bool
    
    init(name: String, velocity: Float, jump: Float, special: Bool) {
        self.name = name
        self.velocity = velocity
        self.jump = jump
        self.special = special
    }
    
}
