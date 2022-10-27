//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene {
    
    
    // GameOver Delegate 사용
    var viewController: GameViewController!
    var recordTime: Int = 0
    var sceneDelegate: GameSceneDelegate?
    
    // Player And LandScape
    var player: SKNode?
    var neonsigns : SKNode?
    var neonsigns2 : SKNode?
    var neonsigns3 : SKNode?
    var moon : SKShapeNode?
    
    // Obstacles
    var obstacles: SKNode?
    var car: SKNode?
    
    
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
    var gameStart = false
    var gameOver = false
    
    // CameraNode
    var cameraNode: SKCameraNode?
    
    // Player State
    var playerStateMachine : GKStateMachine!
    
    // Update CurrentTime
    var previousTimeInterval:TimeInterval = 0.0
    
    // Timer & Speeder & Location
    var timeText: SKLabelNode?
    var timer = Timer()
    var totalTime = 100
    var passedTime = 0
    
    var speederText: SKLabelNode?
    var score: Int = 0
    var playerSpeed = 3.0
    let maxSpeed = 10.0
    let minSpeed = 1.0
    
    var status: SKNode?
    var locationIcon: SKNode?
    var locationBarLength = 530.0
    var positionEndZone = 4200.0
    
    
    // Label
    let speedLabel = SKLabelNode()
    let timeLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    
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
        
        // Delegate 연결
        sceneDelegate = self.viewController
        
        obstacles = childNode(withName: "obstacles")
        car = obstacles?.childNode(withName: "car")
        car?.physicsBody = SKPhysicsBody(circleOfRadius: car!.frame.size.height)
        status = childNode(withName: "status")
        locationIcon = status?.childNode(withName: "locationIcon")
        
        // Timer & Speeder & Location\
        timeText = status?.childNode(withName: "time") as? SKLabelNode
        speederText = status?.childNode(withName: "speed") as? SKLabelNode
        
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
        if playerSpeed < maxSpeed * 1.5 {
            playerSpeed += deltaTime / 5
        }
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
    
    func endGame() {
        self.sceneDelegate?.popupGameOver()
        self.sceneDelegate?.getTimeRap(recordTime: passedTime)
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
        timeText?.text = String(format: "%D", passedTime)
        speederText?.text = String(format: "%.2f", playerSpeed)
        locationIcon?.position.x  = (((player?.position.x)! / positionEndZone) * locationBarLength) - 250
        
        
        // Node 위치 지정
        cameraNode?.position.x = player!.position.x
        status?.position.x = (cameraNode?.position.x)!
        jumpButton?.position.x = (cameraNode?.position.x)! - 450
        jumpButton?.position.y = (cameraNode?.position.y)! - 200
        accelButton?.position.x = (cameraNode?.position.x)! + 250
        accelButton?.position.y = (cameraNode?.position.y)! - 200
        breakButton?.position.x = (cameraNode?.position.x)! + 450
        breakButton?.position.y = (cameraNode?.position.y)! - 200
        
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
            contact.bodyA.node?.physicsBody?.categoryBitMask = 0
        }
        
        if collision.matches(.player, .ending) {
            if !(gameOver) {
                endGame()
                gameOver = true
            }
        }
        
        if collision.matches(.player, .ground) {
            landing()
        }
        
        if collision.matches(.player, .reward) {
            // Drink 획득하는경우
            
            if contact.bodyA.node?.name == "drink" {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                contact.bodyA.node?.removeFromParent()
                playerSpeed += 10
            }
            else if contact.bodyB.node?.name == "drink" {
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
                playerSpeed += 10
            }
            
            // Star획득하는경우
            
            if contact.bodyA.node?.name == "star" {
                playerStateMachine.enter(GodState.self)
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                contact.bodyA.node?.removeFromParent()
            }
            else if contact.bodyB.node?.name == "star" {
                playerStateMachine.enter(GodState.self)
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
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
