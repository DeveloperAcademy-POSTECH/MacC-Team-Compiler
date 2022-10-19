//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit

enum PlayerActive {
    case basic, jumping, accling, breaking
}


class GameScene: SKScene {
    
    var player: SKNode?
    var jumpButton: SKNode?
    var jumpKnob: SKNode?
    
    var cameraNode: SKCameraNode?
    
    var accelButton: SKNode?
    var accelKnob: SKNode?
    
    var breakButton: SKNode?
    var breakKnob: SKNode?
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    
    // NodeSize
    var playerSize:CGSize = CGSize()
    
    
    // Player State
    var playerActive:PlayerActive = .basic
    var playerStateMachine : GKStateMachine!
    
    
    // Engine
    var previousTimeInterval:TimeInterval = 0
    var playerSpeed = 0.1
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        // Player 횡스크롤 이동
        previousTimeInterval = currentTime - 1
        let deltaTime = currentTime - previousTimeInterval
        let diplacement = CGVector(dx: deltaTime * playerSpeed, dy: 0)
        let move = SKAction.move(by: diplacement, duration: 0)
        player!.run(SKAction.sequence([move]))
        updatePlayer()
        print(playerSpeed)
        cameraNode?.position.x = player!.position.x
        cameraNode?.position.y = player!.position.y
        jumpButton?.position.x = (cameraNode?.position.x)! - 300
        jumpButton?.position.y = (cameraNode?.position.y)! - 120
        accelButton?.position.x = (cameraNode?.position.x)! + 220
        accelButton?.position.y = (cameraNode?.position.y)! - 120
        breakButton?.position.x = (cameraNode?.position.x)! + 320
        breakButton?.position.y = (cameraNode?.position.y)! - 120
        
        print(playerStateMachine)
        
    }
    
    override func didMove(to view: SKView) {
        player = childNode(withName: "player")
        
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        
        // Button생성 및 세팅
        jumpButton = childNode(withName: "jumpButton")
        jumpKnob = jumpButton?.childNode(withName: "jumpKnob")
        accelButton = childNode(withName: "accelButton")
        accelKnob = accelButton?.childNode(withName: "accelKnob")
        breakButton = childNode(withName: "breakButton")
        breakKnob = breakButton?.childNode(withName: "breakKnob")
        
        // NodeSize 생성
        playerSize = (player?.frame.size)!
        
        playerStateMachine = GKStateMachine(states: [
        IdleState(playerNode: player!),
        RunningState(playerNode: player!),
        JumpingState(playerNode: player!),
        LandingState(playerNode: player!),
        AccelingState(playerNode: player!),
        BreakingState(playerNode: player!)
        ])
        
        playerStateMachine.enter(IdleState.self)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let jumpKnob = jumpKnob {
                let location = touch.location(in: jumpButton!)
                jumpAction = jumpKnob.frame.contains(location)
                if jumpAction {
                    self.playerActive = .jumping
                }
            }
            
            if let accelKnob = accelKnob {
                let location = touch.location(in: accelButton!)
                accelAction = accelKnob.frame.contains(location)
                if accelAction {
                    self.playerActive = .accling
                }
            }
            
            if let breakKnob = breakKnob {
                let location = touch.location(in: breakButton!)
                breakAction = breakKnob.frame.contains(location)
                if breakAction {
                    self.playerActive = .breaking
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let jumpButton = jumpButton else {return}
        guard let jumpKnob = jumpKnob else {return}
        guard let accelButton = accelButton else {return}
        guard let accelKnob = accelKnob else {return}
        guard let breakButton = breakButton else {return}
        guard let breakKnob = breakKnob else {return}
        for touch in touches {
            let location = touch.location(in: jumpButton)
            jumpAction = jumpKnob.frame.contains(location)
            if jumpAction {
                self.playerActive = .basic
            }
            
            let location2 = touch.location(in: accelButton)
            accelAction = accelKnob.frame.contains(location2)
            if accelAction {
                self.playerActive = .basic
            }
            
            let location3 = touch.location(in: breakButton)
            breakAction = breakKnob.frame.contains(location3)
            if breakAction {
                self.playerActive = .basic
            }
        }
    }
    
    // MARK: - Action
    
    func doJump() {
        playerActive = .basic
        playerStateMachine.enter(JumpingState.self)
    }

    func doAccel() {
        self.playerSpeed += 0.1
        playerStateMachine.enter(AccelingState.self)
    }
    
    func doBreak() {
        if playerSpeed > 0.0 {
            self.playerSpeed -= 0.1
        }
        playerStateMachine.enter(BreakingState.self)
    }
    
    func updatePlayer() {
        switch playerActive {
        case .jumping:
            doJump()
        case .accling:
            doAccel()
        case .breaking:
            doBreak()
        default: break
        }
    }
}

