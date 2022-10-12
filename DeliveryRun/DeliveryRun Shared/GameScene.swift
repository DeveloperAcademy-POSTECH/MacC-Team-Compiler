//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit

class GameScene: SKScene {
    
    var player: SKNode?
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "player0")
    }

}
