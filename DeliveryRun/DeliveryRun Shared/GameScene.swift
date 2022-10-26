//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // GameOver
    var viewController: GameViewController!
    
    // Player And LandScape
    var player: SKNode?
    var neonsigns : SKNode?
    var neonsigns2 : SKNode?
    var neonsigns3 : SKNode?
    var moon : SKShapeNode?
    
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
    var rewardIsNotTouched = true
    var gameStart = false
    
    // CameraNode
    var cameraNode: SKCameraNode?
    
    // Player State
    var playerStateMachine : GKStateMachine!
    
    // Update CurrentTime
    var previousTimeInterval:TimeInterval = 0.0
    
    // Timer & Speeder & Location
    var timerNode: SKNode?
    var timeText: SKLabelNode?
    var timer = Timer()
    var totalTime = 100
    var passedTime = 0
    
    var speederNode: SKNode?
    var speederText: SKLabelNode?
    var score: Int = 0
    var playerSpeed = 3.0
    let maxSpeed = 10.0
    let minSpeed = 1.0
    
    var location: SKNode?
    var locationIcon: SKNode?
    var locationBarLength = 600.0
    var positionEndZone = 4200.0
    
    
    // Label
    let speedLabel = SKLabelNode()
    let timeLabel = SKLabelNode()
    
    @objc func updateTimer() {
        if totalTime > passedTime {
            passedTime += 1
        } else {
            timer.invalidate()
        }
    }
    
//MARK: Scene 실행 시
    override func didMove(to view: SKView) {
        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        // Timer & Speeder & Location
        
        timerNode = childNode(withName: "timer")
        timeText = timerNode?.childNode(withName: "time") as? SKLabelNode
        speederNode = childNode(withName: "speeder")
        speederText = speederNode?.childNode(withName: "speed") as? SKLabelNode
        
        location = childNode(withName: "location")
        locationIcon = location?.childNode(withName: "locationIcon")
        
//        // Moon 생성
//        moon = SKShapeNode(circleOfRadius: 50)
//        moon?.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        moon?.fillColor = SKColor.yellow
//        moon?.position = CGPoint(x: 400, y: 270)
//        addChild(moon!)
        
        // Collision
        physicsWorld.contactDelegate = self
        
        // Scene.sks Node 연결
        player = childNode(withName: "player")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        neonsigns = childNode(withName: "neonsigns")
        neonsigns2 = childNode(withName: "neonsigns2")
        neonsigns3 = childNode(withName: "neonsigns3")
        
        // Button생성 및 세팅
        jumpButton = childNode(withName: "jumpButton")
        jumpArea = jumpButton?.childNode(withName: "jumpArea")
        accelButton = childNode(withName: "accelButton")
        accelArea = accelButton?.childNode(withName: "accelArea")
        breakButton = childNode(withName: "breakButton")
        breakArea = breakButton?.childNode(withName: "breakArea")
        
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
        gameStart = true
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
                    acceling(deltaTime: 0)
                }
            }
            
            
            if let breakArea = breakArea {
                let location = touch.location(in: breakButton!)
                breakAction = breakArea.frame.contains(location)
                if breakAction {
                    breaking(deltaTime: 0)
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
                running(deltaTime: 0)
                jumpAction = false
            }
            
            let accelButtonArea = touch.location(in: accelButton!)
            accelAction = accelArea!.frame.contains(accelButtonArea)
            if accelAction {
                running(deltaTime: 0)
                accelAction = false
            }
            
            let breakButtonArea = touch.location(in: breakButton!)
            breakAction = breakArea!.frame.contains(breakButtonArea)
            if breakAction {
                running(deltaTime: 0)
                breakAction = false
            }
        }
    }
}

// MARK: GameAcion
extension GameScene {
    func running(deltaTime:TimeInterval) {
        if !(gameStart) {
            playerSpeed = 0.0
        } else {
            if (playerSpeed < minSpeed){
                playerSpeed = minSpeed
            } else if playerSpeed >= minSpeed && playerSpeed < maxSpeed {
                self.playerSpeed += deltaTime / 20
            } else if playerSpeed > maxSpeed + deltaTime - deltaTime / 100 {
                self.playerSpeed -= deltaTime / 20
            }
        }
        playerStateMachine.enter(RunningState.self)
    }
    func jumping() {
        playerStateMachine.enter(JumpingState.self)
    }
    func landing() {
        playerStateMachine.enter(LandingState.self)
    }
    func acceling(deltaTime:TimeInterval) {
        playerSpeed += deltaTime / 5
        playerStateMachine.enter(AccelingState.self)
    }
    func breaking(deltaTime:TimeInterval) {
        if playerSpeed < minSpeed {
            playerSpeed = minSpeed
        }
        playerSpeed -= deltaTime / 5
        playerStateMachine.enter(BreakingState.self)
    }
    func damaging() {
        playerSpeed = minSpeed
        playerStateMachine.enter(DamageState.self)
    }
    
    func invicible() {
        player?.physicsBody?.categoryBitMask = 0
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.player?.physicsBody?.categoryBitMask = 2
        }
    }
    
    func gameOver() {
        self.viewController.popupGameOver()
        self.viewController.getTimeRap(passedTime: passedTime)
        
//        let reveal = SKTransition.reveal(with: .down,
//                                                 duration: 1)
//        let newScene = GameScene(fileNamed: "GameClear")
//
//        scene?.view!.presentScene(newScene!,transition: reveal)
        
//        let scene = GameScene(fileNamed: "GameOver")
//        let transition = SKTransition.moveIn(with: .right, duration: 1)
//        self.view?.presentScene(scene, transition: transition)
    func getReward() {
        score += 1
        scoreLabel.text = String(score)
    }
}

// MARK: GameLoop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        // Player 횡스크롤 이동
        if currentTime > 1 {
            previousTimeInterval = currentTime - 1
        }
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        let diplacement = CGVector(dx: deltaTime * playerSpeed, dy: 0)
        let move = SKAction.move(by: diplacement, duration: 0)
        player!.run(SKAction.sequence([move]))
        if jumpAction {
            jumping()
        } else if accelAction {
            acceling(deltaTime: deltaTime)
        } else if breakAction {
            breaking(deltaTime: deltaTime)
        } else {
            running(deltaTime: deltaTime)
        }
        timeText!.text = String(format: "%D", passedTime)
        speederText!.text = String(format: "%.2f", playerSpeed)
        locationIcon?.position.x  = (((player?.position.x)! / positionEndZone) * locationBarLength) - 300
        rewardIsNotTouched = true
        

        // Node 위치 지정
        cameraNode?.position.x = player!.position.x
        location?.position.x = (cameraNode?.position.x)!
        timerNode?.position.x = (cameraNode?.position.x)! - 400
        speederNode?.position.x = (cameraNode?.position.x)! - 400
        jumpButton?.position.x = (cameraNode?.position.x)! - 300
        jumpButton?.position.y = (cameraNode?.position.y)! - 120
        accelButton?.position.x = (cameraNode?.position.x)! + 220
        accelButton?.position.y = (cameraNode?.position.y)! - 120
        breakButton?.position.x = (cameraNode?.position.x)! + 320
        breakButton?.position.y = (cameraNode?.position.y)! - 120
        
        // Parallax Animation
        parallaxAnimation()
        
    }
}


// MARK: Collision
extension GameScene: SKPhysicsContactDelegate {
    
    struct Collision {
        
        enum Masks: Int {
            case damage, player, reward, ground, ending
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
            invicible()
        }
        
        if collision.matches(.player, .ending) {
            gameOver()
        }
        
        if collision.matches(.player, .ground) {
            landing()
        }
        
        if collision.matches(.player, .reward) {
            if contact.bodyA.node?.name == "jewel" {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
            }
            else if contact.bodyB.node?.name == "jewel" {
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
            }
            if rewardIsNotTouched {
                getReward()
                rewardIsNotTouched = false
            }
        }
    }
}


// MARK: ParallaxAnimation
extension GameScene {
    func parallaxAnimation() {
        let parallax1 = SKAction.moveTo(x: (player?.position.x)! / (10), duration: 0.0)
        neonsigns?.run(parallax1)
        let parallax2 = SKAction.moveTo(x: (player?.position.x)! / (20), duration: 0.0)
        neonsigns2?.run(parallax2)
        let parallax3 = SKAction.moveTo(x: (player?.position.x)! / (40), duration: 0.0)
        neonsigns3?.run(parallax3)
    }
}


