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
        player = childNode(withName: "player")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches { self.touchDown(atPoint:touch.location(in:self))}
    }
    
    func touchDown(atPoint pos: CGPoint) {
        let distance = CGPoint(x: pos.x, y:player!.position.y)
        let movePlayer = SKAction.move(to: distance, duration: 0.5)

        player!.run(SKAction.sequence([movePlayer]))
    }

}
