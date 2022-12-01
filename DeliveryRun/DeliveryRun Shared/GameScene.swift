//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene{
    
    var viewController: GameViewController!
    let userDefault = UserDefaultData.shared
    
    //Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    var previousTimeRecord:Double = 0.00
    var isClear:Bool = false
    
    
    // Player And LandScape
    let player = SKSpriteNode(imageNamed: "player0")
    
    
    // Buttons
    var Button: SKNode?
    var jumpButton: SKNode?
    var accelButton: SKNode?
    var breakButton: SKNode?
    var pauseButton: SKNode?
    
    // Screen
    private let pauseScreen = PauseScreen()
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    var startAction = false
    var pauseAction = false
    
    // CameraNode
    var cameraNode: SKCameraNode?
    
    // Player State
    var playerStateMachine : GKStateMachine!
    
    // Update CurrentTime
    var previousTimeInterval:TimeInterval = Constant.previousTimeInterval
    
    // Timer & Speeder & Location
    var timeText: SKLabelNode?
    var timer = Timer()
    
    let endTime = Constant.endTime
    var elapsedTime = Constant.elapsedTime
    
    
    var speederText: SKLabelNode?
    var score: Int = Constant.score
    var playerSpeed = Constant.playerSpeed
    let maxSpeed = Constant.maxSpeed
    let minSpeed = Constant.minSpeed
    
    var status: SKNode?
    var locationIcon: SKNode?
    var locationBarWidth = Constant.locationBarWidth
    var EndZoneWidth = Constant.EndZoneWidth
    
    
    // Label
    let speedLabel = SKLabelNode()
    let timeLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
    
    @objc func updateTimer() {
        if endTime > elapsedTime {
            elapsedTime += 1
        } else {
            timer.invalidate()
        }
    }
    
    //MARK: Scene 실행 시
    override func didMove(to view: SKView) {
        
        // UserDefaultTrackingData
        UserDefaultData.findPath()
        self.jumpData = UserDefaultData.staticDefaults.integer(forKey:"JumpData")
        self.breakData = UserDefaultData.staticDefaults.integer(forKey:"BreakData")
        self.collisionData = UserDefaultData.staticDefaults.integer(forKey:"CollisionData")
        self.previousTimeRecord = UserDefaultData.staticDefaults.double(forKey: "Record1")
        self.isClear = UserDefaultData.staticDefaults.bool(forKey: "FirstStageClear")
        
        // Physical Delegate
        physicsWorld.contactDelegate = self
        
        // Node 생성
        setupNode()
        generatePlayer()
        
        // PlayerState 가져오기
        playerStateMachine = GKStateMachine(states: [
            RunningState(playerNode: player),
            JumpingState(playerNode: player),
            LandingState(playerNode: player),
            AccelingState(playerNode: player),
            BreakingState(playerNode: player),
            DamageState(playerNode: player),
            GodState(playerNode:player)
        ])
        playerStateMachine.enter(RunningState.self)
    }
    
    // Player 생성
    private func generatePlayer() {
        player.position = CGPoint(x:frame.midX, y: frame.midY)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height/2)
        player.scale(to: CGSize(width: 120, height: 120))
        player.physicsBody?.categoryBitMask = 2
        player.physicsBody?.collisionBitMask = 8
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 0.13
        addChild(player)
    }
    
    // Node 설정
    private func setupNode() {
        // Base Node
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
        pauseButton = Button?.childNode(withName: "pauseButton")
    }
}

// MARK: Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !startAction {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
        
        startAction = true
        
        for touch in touches {
            let location = touch.location(in: Button!)
            
            jumpAction = jumpButton!.frame.contains(location)
            accelAction = accelButton!.frame.contains(location)
            breakAction = breakButton!.frame.contains(location)
            pauseAction = pauseButton!.frame.contains(location)
            
            if pauseAction {
                pause()
            }
            
            if jumpAction {
                jumping()
                jumpData += 1
            }
            if accelAction {
                acceling(deltaTime: 0)
            }
            if breakAction {
                breaking(deltaTime: 0)
                breakData += 1
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

// MARK: Game Acion
extension GameScene {
    
    // Playee Function
    
    func running(deltaTime:TimeInterval) {
        if !(startAction) {
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
        player.physicsBody?.categoryBitMask = 0
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            self.player.physicsBody?.categoryBitMask = 2
        }
    }
    
    // Game UI Function
    func pause() {
        self.viewController.pauseView.isHidden = false
        self.view?.isPaused = true
    }
    func resume() {
        self.viewController.pauseView.isHidden = true
        self.view?.isPaused = false
    }
    
    func restartGame() {
        self.viewController.pauseView.isHidden = true
        self.view?.isPaused = false
        
    }
    
    func reTryGame() {
        self.viewController.arrivalView.isHidden = true
    }
    
    func arrival(timeRecord:Double) {
        self.viewController.arrivalView.isHidden = false
        self.viewController.PreviousRecord.text = String(format: "당신의 이전기록은 %.2f 입니다", previousTimeRecord)
        self.viewController.PresentRecord.text = String(format: "당신의 현재기록은 %.2f 입니다", timeRecord)
        userDefault.firstStageCompleted(timeRecord: timeRecord)
        userDefault.trackingDataSave(jumpData: jumpData, breakData: breakData, collisionData: collisionData)
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
            player.run(SKAction.sequence([move]))
            
            if jumpAction {
                jumping()
            } else if accelAction {
                acceling(deltaTime: deltaTime)
            } else if breakAction {
                breaking(deltaTime: deltaTime)
            } else {
                running(deltaTime: deltaTime)
            }
        
        timeText?.text = String(format: "%D", elapsedTime)
        speederText?.text = String(format: "%.2f", playerSpeed)
        locationIcon?.position.x  = (((player.position.x) / EndZoneWidth) * locationBarWidth) - 250
        
        // Node 위치 지정
        cameraNode?.position.x = player.position.x + 300
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
            arrival(timeRecord: Double(elapsedTime))
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

