//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit

enum PlayerActive {
    case running, jumping, accling, breaking, damaging
}


class GameScene: SKScene {
    
    var player: SKNode?
    
    var jumpButton: SKNode?
    var jumpKnob: SKNode?
    var accelButton: SKNode?
    var accelKnob: SKNode?
    var breakButton: SKNode?
    var breakKnob: SKNode?
    var neon1 : SKNode?
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    
    var cameraNode: SKCameraNode?
    
    // NodeSize
    var playerSize:CGSize = CGSize()
    
    
    // Player State
    var playerActive:PlayerActive = .running
    var playerStateMachine : GKStateMachine!
    
    
    // Engine
    var previousTimeInterval:TimeInterval = 0
    var playerSpeed = 1.0
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        // Player 횡스크롤 이동
        previousTimeInterval = currentTime - 1
        let deltaTime = currentTime - previousTimeInterval
        let diplacement = CGVector(dx: deltaTime * playerSpeed, dy: 0)
        let move = SKAction.move(by: diplacement, duration: 0)
        
        player!.run(SKAction.sequence([move]))
        updatePlayer()
        print(playerStateMachine.currentState)
        
        // Node 위치 지정
        cameraNode?.position.x = player!.position.x
        cameraNode?.position.y = player!.position.y
        jumpButton?.position.x = (cameraNode?.position.x)! - 300
        jumpButton?.position.y = (cameraNode?.position.y)! - 120
        accelButton?.position.x = (cameraNode?.position.x)! + 220
        accelButton?.position.y = (cameraNode?.position.y)! - 120
        breakButton?.position.x = (cameraNode?.position.x)! + 320
        breakButton?.position.y = (cameraNode?.position.y)! - 120
    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        player = childNode(withName: "player")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        // Button생성 및 세팅
        jumpButton = childNode(withName: "jumpButton")
        jumpKnob = jumpButton?.childNode(withName: "jumpKnob")
        accelButton = childNode(withName: "accelButton")
        accelKnob = accelButton?.childNode(withName: "accelKnob")
        breakButton = childNode(withName: "breakButton")
        breakKnob = breakButton?.childNode(withName: "breakKnob")
        neon1 = childNode(withName: "neon1")
        
        // NodeSize 생성
        playerSize = (player?.frame.size)!
        
        playerStateMachine = GKStateMachine(states: [
        RunningState(playerNode: player!),
        JumpingState(playerNode: player!),
        LandingState(playerNode: player!),
        AccelingState(playerNode: player!),
        BreakingState(playerNode: player!),
        DamageState(playerNode: player!),
        GodState(playerNode:player!)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let jumpKnob = jumpKnob {
                let location = touch.location(in: jumpButton!)
                jumpAction = jumpKnob.frame.contains(location)
                if jumpAction {
                    playerActive = .jumping
                }
            }
            
            if let accelKnob = accelKnob {
                let location = touch.location(in: accelButton!)
                accelAction = accelKnob.frame.contains(location)
                if accelAction {
                    playerActive = .accling
                }
            }
            
            if let breakKnob = breakKnob {
                let location = touch.location(in: breakButton!)
                breakAction = breakKnob.frame.contains(location)
                if breakAction {
                    playerActive = .breaking
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let jumplocation = touch.location(in: jumpButton!)
            jumpAction = jumpKnob!.frame.contains(jumplocation)
            if jumpAction {
                playerActive = .running
            }
            
            let accellocation = touch.location(in: accelButton!)
            accelAction = accelKnob!.frame.contains(accellocation)
            if accelAction {
                playerActive = .running
            }
            
            let breaklocation = touch.location(in: breakButton!)
            breakAction = breakKnob!.frame.contains(breaklocation)
            if breakAction {
                playerActive = .running
            }
        }
    }
    
    // MARK: - Action
    
    func doRunning() {
        playerActive = .running
        playerStateMachine.enter(RunningState.self)
    }
    func doJump() {
        playerActive = .jumping
        playerStateMachine.enter(JumpingState.self)
    }

    func doAccel() {
        self.playerSpeed += 0.1
        playerActive = .accling
        playerStateMachine.enter(AccelingState.self)
    }
    
    func doBreak() {
        if playerSpeed > 0.3 {
            self.playerSpeed -= 0.1
        }
        else {
            self.playerSpeed = 0.3
        }
        playerActive = .breaking
        playerStateMachine.enter(BreakingState.self)
    }
    
    func doDamage() {
        playerActive = .damaging
        playerStateMachine.enter(DamageState.self)
    }
    
    func updatePlayer() {
        switch playerActive {
        case .jumping:
            doJump()
        case .accling:
            doAccel()
        case .breaking:
            doBreak()
        case .damaging:
            doDamage()
        default:
            doRunning()
        }
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
            playerActive = .damaging
        }
        
        if collision.matches(.player, .ground) {
            playerStateMachine.enter(LandingState.self)
        }
        
        if collision.matches(.player, .reward) {
            playerStateMachine.enter(GodState.self)
        }
    }
}
