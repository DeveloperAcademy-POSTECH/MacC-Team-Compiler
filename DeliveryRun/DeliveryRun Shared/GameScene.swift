//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit

class GameScene: SKScene {
    var player: SKNode?
    var jumpButton: SKNode?
    var jumpKnob: SKNode?
    
    // Boolean
    var jumpAction = false
    
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "player")
        jumpButton = childNode(withName: "jumpButton")
        jumpKnob = jumpButton?.childNode(withName: "jumpKnob")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let jumpKnob = jumpKnob {
                let location = touch.location(in: jumpButton!)
                jumpAction = jumpKnob.frame.contains(location)
                if jumpAction {
                    self.jumpButtonPressed()
                }
            }
            
            let location = touch.location(in: self)
            if !(jumpButton?.contains(location))! {
                self.noJumpButton()
                self.touchDown(atPoint: location)
            }
        }
    }
    
//    // Player Position 이동
//
    func touchDown(atPoint pos: CGPoint) {
        let distance = CGPoint(x: pos.x, y:player!.position.y)
        let movePlayer = SKAction.move(to: distance, duration: 0.5)
        

        player!.run(SKAction.sequence([movePlayer]))
    }
    
    func jumpButtonPressed() {
        print("Jump")
    }
    
    func noJumpButton() {
        print("No")
    }
}
