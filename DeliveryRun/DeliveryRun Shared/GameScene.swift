//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    // Player And LandScape
    var player: SKNode?
    var neonsigns: SKNode?
    var neon1 : SKNode?
    var neon2 : SKNode?
    var neon3 : SKNode?
    var moon : SKNode?
    
    // Buttons
    var jumpButton: SKNode?
    var jumpArea: SKNode?
    var accelButton: SKNode?
    var accelArea: SKNode?
    var breakButton: SKNode?
    var breakArea: SKNode?
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    
    // CameraNode
    var cameraNode: SKCameraNode?
    
    // Player State
    var playerStateMachine : GKStateMachine!
    
    // Engine
    var previousTimeInterval:TimeInterval = 0.0
    var scrollSpeed = 1.0
    
    
    override func didMove(to view: SKView) {
        
        // Collision
        physicsWorld.contactDelegate = self
        
        // Scene.sks Node 연결
        player = childNode(withName: "player")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        neon1 = childNode(withName: "neon1")
        neonsigns = childNode(withName: "neonsigns")
        neon1 = neonsigns?.childNode(withName: "neon1")
        neon2 = neonsigns?.childNode(withName: "neon2")
        neon3 = neonsigns?.childNode(withName: "neon3")
        let shapeNode = SKShapeNode(circleOfRadius: 80)
        moon?.addChild(shapeNode)
        
        // Button생성 및 세팅
        jumpButton = childNode(withName: "jumpButton")
        jumpArea = jumpButton?.childNode(withName: "jumpArea")
        accelButton = childNode(withName: "accelButton")
        accelArea = accelButton?.childNode(withName: "accelArea")
        breakButton = childNode(withName: "breakButton")
        breakArea = breakButton?.childNode(withName: "breakArea")
        
        //        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {(timer) in
        //            self.createNeon()
        //        }
        
        // PlayerState 가져오기
        playerStateMachine = GKStateMachine(states: [
            RunningState(playerNode: player!),
            JumpingState(playerNode: player!),
            LandingState(playerNode: player!),
            AccelingState(playerNode: player!),
            BreakingState(playerNode: player!),
            DamageState(playerNode: player!),
            GodState(playerNode:player!)
        ])
        playerStateMachine.enter(RunningState.self)
    }
}
// MARK: Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let jumpArea = jumpArea {
                let location = touch.location(in: jumpButton!)
                jumpAction = jumpArea.frame.contains(location)
                if jumpAction {
                    jumping()
                }
            }
            
            if let accelArea = accelArea {
                let location = touch.location(in: accelButton!)
                accelAction = accelArea.frame.contains(location)
                if accelAction {
                    acceling()
                }
            }
            
            
            if let breakArea = breakArea {
                let location = touch.location(in: breakButton!)
                breakAction = breakArea.frame.contains(location)
                if breakAction {
                    breaking()
                }
            }
            let location = touch.location(in: self)
            if !(jumpButton?.contains(location))! {
                jumpAction = false
            }
            if !(accelButton?.contains(location))! {
                accelAction = false
            }
            if !(breakButton?.contains(location))! {
                breakAction = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let jumpButtonArea = touch.location(in: jumpButton!)
            jumpAction = jumpArea!.frame.contains(jumpButtonArea)
            if jumpAction {
                running()
                jumpAction = false
            }
            
            let accelButtonArea = touch.location(in: accelButton!)
            accelAction = accelArea!.frame.contains(accelButtonArea)
            if accelAction {
                running()
                accelAction = false
            }
            
            let breakButtonArea = touch.location(in: breakButton!)
            breakAction = breakArea!.frame.contains(breakButtonArea)
            if breakAction {
                running()
                breakAction = false
            }
        }
    }
}
// MARK: GameAcion
extension GameScene {
    // PlayerStateEnter및 ScrollSpeed 변화
    func running() {
        if scrollSpeed < 5.0 {
            scrollSpeed += 0.1
        }
        playerStateMachine.enter(RunningState.self)
    }
    func jumping() {
        playerStateMachine.enter(JumpingState.self)
    }
    func landing() {
        playerStateMachine.enter(LandingState.self)
    }
    func acceling() {
        playerStateMachine.enter(AccelingState.self)
        if scrollSpeed < 5.0 {
            scrollSpeed += 0.2
        } else {
            scrollSpeed = 5.0
            print("Now Max Scroll Speed")
        }
    }
    func breaking() {
        playerStateMachine.enter(BreakingState.self)
        if scrollSpeed > 1.0 {
            scrollSpeed -= 0.2
        } else {
            scrollSpeed = 1.0
            print("Now Min Scroll Speed")
        }
    }
    func damaging() {
        playerStateMachine.enter(DamageState.self)
        if scrollSpeed > 1.0 {
            scrollSpeed = 1.0
        } else {
            print("Now Min Scroll Speed")
        }
    }
}

// MARK: GameLoop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        // Player 횡스크롤 이동
        previousTimeInterval = currentTime - 1
        let deltaTime = currentTime - previousTimeInterval
        let diplacement = CGVector(dx: deltaTime * scrollSpeed, dy: 0)
        let move = SKAction.move(by: diplacement, duration: 0)
        player!.run(SKAction.sequence([move]))
      
        if jumpAction {
            jumping()
        } else if accelAction {
            acceling()
        } else if breakAction {
            breaking()
        } else {
            running()
        }
        // Node 위치 지정
        cameraNode?.position.x = player!.position.x
        cameraNode?.position.y = player!.position.y
        jumpButton?.position.x = (cameraNode?.position.x)! - 300
        jumpButton?.position.y = (cameraNode?.position.y)! - 120
        accelButton?.position.x = (cameraNode?.position.x)! + 220
        accelButton?.position.y = (cameraNode?.position.y)! - 120
        breakButton?.position.x = (cameraNode?.position.x)! + 320
        breakButton?.position.y = (cameraNode?.position.y)! - 120
        
        
        let parallax1 = SKAction.moveTo(x: (player?.position.x)! / (10), duration: 0.0)
        neon1?.run(parallax1)
        let parallax2 = SKAction.moveTo(x: (player?.position.x)! / (20), duration: 0.0)
        neon2?.run(parallax2)
        let parallax3 = SKAction.moveTo(x: (player?.position.x)! / (40), duration: 0.0)
        neon3?.run(parallax3)
        let parallax4 = SKAction.moveTo(x: ((player?.position.x)! + 250), duration: 0.0)
        moon?.run(parallax4)
    }
}


// MARK: Collision
extension GameScene: SKPhysicsContactDelegate {
    
    struct Collision {
        
        enum Masks: Int {
            case damage, player, reward, ground
            var bitmask: UInt32 { return 1 << self.rawValue }
        }
        
        let masks: (first: UInt32, second: UInt32)
        
        func matches (_ first: Masks, _ second: Masks) -> Bool {
            return (first.bitmask == masks.first && second.bitmask == masks.second) ||
            (first.bitmask == masks.second && second.bitmask == masks.first)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = Collision(masks: (first: contact.bodyA.categoryBitMask, second: contact.bodyB.categoryBitMask))
        
        if collision.matches(.player, .damage) {
            damaging()
        }
        
        if collision.matches(.player, .ground) {
            landing()
        }
        
        if collision.matches(.player, .reward) {
            damaging()
        }
    }
}


// MARK: ParallaxAnimation
extension GameScene {
    func createNeon() {
        let  node = SKSpriteNode(imageNamed: "firstNeon0")
        node.name = "Neons1"
        let randomXposition = Int(arc4random_uniform(UInt32(self.size.width)))
        
        node.size.width = 100
        node.size.height = 100
        
        node.position = CGPoint(x: (player?.position.x)! + 200, y: 150)
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        node.zPosition = 5
        
        addChild(node)
    }
}
