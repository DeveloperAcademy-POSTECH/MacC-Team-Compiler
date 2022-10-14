//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit

class GameScene: SKScene {
//
//    var cameraNode: SKCameraNode?
    var player: SKNode?
    var jumpButton: SKNode?
    var jumpKnob: SKNode?
    
    var accelButton: SKNode?
    var accelKnob: SKNode?
    
    var breakButton: SKNode?
    var breakKnob: SKNode?
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    
    // Engine
    var previousTimeInterval:TimeInterval = 0
    var playerSpeed = 1.0
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        previousTimeInterval = currentTime - 1
        let deltaTime = currentTime - previousTimeInterval
        let diplacement = CGVector(dx: deltaTime * playerSpeed, dy: 0)
        let move = SKAction.move(by: diplacement, duration: 0)
        player!.run(SKAction.sequence([move]))
        print(previousTimeInterval, currentTime)
        
//
//        cameraNode?.position.x = player!.position.x + 150
    }
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "player")
        jumpButton = childNode(withName: "jumpButton")
        jumpKnob = jumpButton?.childNode(withName: "jumpKnob")
        
        accelButton = childNode(withName: "accelButton")
        accelKnob = accelButton?.childNode(withName: "accelKnob")

        
        breakButton = childNode(withName: "breakButton")
        breakKnob = breakButton?.childNode(withName: "breakKnob")
        
//        cameraNode = childNode(withName:"cameraNode") as? SKCameraNode

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let jumpKnob = jumpKnob {
                let location = touch.location(in: jumpButton!)
                jumpAction = jumpKnob.frame.contains(location)
                if jumpAction {
                    doJump(atPoint: CGPoint(x:player!.position.x, y: player!.position.y + 50))
                }
            }
            
            if let accelKnob = accelKnob {
                let location = touch.location(in: accelButton!)
                accelAction = accelKnob.frame.contains(location)
                if accelAction {
                    doAccel()
                }
            }
            
            if let breakKnob = breakKnob {
                let location = touch.location(in: breakButton!)
                breakAction = breakKnob.frame.contains(location)
                if breakAction {
                    doBreak()
                }
            }
            
            let location = touch.location(in: self)
            if !(jumpButton!.contains(location) || accelButton!.contains(location) || breakButton!.contains(location)) {
//                self.touchDown(atPoint: location)
            }
        }
    }

// MARK: - Action
//    func touchDown(atPoint pos: CGPoint) {
//        let distance = CGPoint(x: pos.x, y:player!.position.y)
//        let movePlayer = SKAction.move(to: distance, duration: 0.5)
//
//        player!.run(SKAction.sequence([movePlayer]))
//    }
    
    func doJump(atPoint pos: CGPoint) {
        player!.run(.applyForce(CGVector(dx: 0, dy: 200), duration: 0.5))
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {(timer) in
            print("Can Jump")
        }
        
    }
    
    func doAccel() {
        self.playerSpeed += 0.1
        let distance = CGVector(dx: 50, dy: 0)
        let move = SKAction.move(by: distance, duration: 0.5)
        player!.run(move)
    }
    
    func doBreak() {
        self.playerSpeed -= 0.1
    }
}

