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
    var moon : SKShapeNode?
    
    // Buttons
    var Button: SKNode?
    var jumpButton: SKNode?
    var accelButton: SKNode?
    var breakButton: SKNode?
    
    // Screen
    var pauseScreen: SKNode = PauseScreen()
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    var gameStart = false
    var isGamePaused = false
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
    var positionEndZone = 21060.0
    
    
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
        
        // Delegate 연결
        sceneDelegate = self.viewController
        physicsWorld.contactDelegate = self
        
        // Node 생성
        setupNode()
        
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
    
    private func setupNode() {
        // Base Node
        player = childNode(withName: "player")
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode
        
        // Status Bar
        status = childNode(withName: "status")
        locationIcon = status?.childNode(withName: "locationIcon")
        timeText = status?.childNode(withName: "time") as? SKLabelNode
        speederText = status?.childNode(withName: "speed") as? SKLabelNode
        
        // Button
        Button = childNode(withName: "Button")
        jumpButton = Button?.childNode(withName: "jumpButton")
        accelButton = Button?.childNode(withName: "accelButton")
        breakButton = Button?.childNode(withName: "breakButton")
        
        addChild(pauseScreen)
    }
}

// MARK: Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStart {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        gameStart = true
        
        for touch in touches {
            let location = touch.location(in: Button!)
            
            jumpAction = jumpButton!.frame.contains(location)
            accelAction = accelButton!.frame.contains(location)
            breakAction = breakButton!.frame.contains(location)
            
            if jumpAction {
                jumping()
            }
            if accelAction {
                acceling(deltaTime: 0)
            }
            if breakAction {
                breaking(deltaTime: 0)
            }
            
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
            let location = touch.location(in: self)
            
            jumpAction = jumpButton!.frame.contains(location)
            accelAction = accelButton!.frame.contains(location)
            breakAction = breakButton!.frame.contains(location)
            
            if jumpAction {
                running(deltaTime: 0)
                jumpAction = false
            }
            if accelAction {
                running(deltaTime: 0)
                accelAction = false
            }
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
            if (playerSpeed < minSpeed) {
                playerSpeed = minSpeed
            } else if playerSpeed >= minSpeed && playerSpeed < maxSpeed {
                if playerSpeed >= maxSpeed {
                    self.playerSpeed = maxSpeed
                }
                else {
                    self.playerSpeed += deltaTime / 20
                }
            } else if playerSpeed > maxSpeed {
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
        if playerSpeed <= maxSpeed * 1.5 {
            playerSpeed += deltaTime / 5
            if playerSpeed > maxSpeed * 1.5 {
                playerSpeed = maxSpeed * 1.5
            }
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


// MARK: Game Loop
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
        
        // Node 위치 지정®
        cameraNode?.position.x = player!.position.x + 300
        status?.position.x = (cameraNode?.position.x)!
        Button?.position.x = (cameraNode?.position.x)!
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
            // Drink 획득하는 경우
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
            
            // Star 획득하는 경우
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
