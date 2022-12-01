//
//  GameScene.swift
//  DeliveryRun Shared
//
//  Created by HWANG-C-K on 2022/10/11.
//

import SpriteKit
import GameplayKit
import AVFoundation


class GameScene: SKScene {
    
    // GameOver Delegate 사용
    var viewController: GameViewController!
    var recordTime: Int = 0
    var sceneDelegate: GameSceneDelegate?
    
    // Player And LandScape
    let player = SKSpriteNode(imageNamed: "player0")
    var moon : SKShapeNode?
    
    // Buttons
    var Button: SKNode!
    var jumpButton: SKSpriteNode!
    var accelButton: SKSpriteNode!
    var breakButton: SKSpriteNode!
    var itemButton: SKSpriteNode!
    var itemImage: SKSpriteNode!
    var pauseButton: SKSpriteNode!
    
    // HUD
    private let pauseScreen = PauseScreen()
    var HUD: SKNode!
    var locationBar: SKShapeNode!
    var startLineShort: SKSpriteNode!
    var finishLineShort: SKSpriteNode!
    var playerLocation: SKShapeNode!
    var timerIcon: SKSpriteNode!
    var speederIcon: SKSpriteNode!
    var timerText: SKLabelNode!
    var speederText: SKLabelNode!
    var locationBarLength: Double!
    
    // Boolean
    var jumpAction = false
    var accelAction = false
    var breakAction = false
    var itemAction = false
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
    var timer = Timer()
    var totalTime = 100
    var passedTime = 0
    
    var score: Int = 0
    var playerSpeed = 3.0
    let maxSpeed = 10.0
    let minSpeed = 1.0
    var endPoint = 20000.0
    
    // Sound
    let soundPlayer = SoundPlayer()
    
    var soundPlayerModel = Sound(audioPlayer: AVAudioPlayer())
    
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
        cameraNode = childNode(withName: "cameraNode") as? SKCameraNode

        setupPlayer()
        setupButtonNode()
        setupHUDNode()
        
        // PlayerState 가져오기
        playerStateMachine = GKStateMachine(states: [
            RunningState(playerNode: player),
            JumpingState(playerNode: player),
            LandingState(playerNode: player),
            AccelingState(playerNode: player),
            BreakingState(playerNode: player),
            DamageState(playerNode: player),
            StarState(playerNode:player)
        ])
        playerStateMachine.enter(RunningState.self)
    }
    
    // Player 생성
    private func setupPlayer() {
        player.position = CGPoint(x:0, y: 0)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height/2)
        player.scale(to: CGSize(width: 120, height: 120))
        player.physicsBody?.categoryBitMask = 2
        player.physicsBody?.collisionBitMask = 8
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.mass = 0.13
        addChild(player)
    }
    
    // Button Node 설정
    private func setupButtonNode() {
        // Button
        Button = SKNode()
        Button.name = "Button"
        Button.zPosition = 5.0
        addChild(Button)
        
        // Break Button
        breakButton = SKSpriteNode(imageNamed: "Break Button")
        breakButton.name = "Break"
        breakButton.scale(to: CGSize(width: 125, height: 125))
        breakButton.position = CGPoint(x: -470, y: -200)
        breakButton.zPosition = 5.0
        Button.addChild(breakButton)
        
        // Accel Button
        accelButton = SKSpriteNode(imageNamed: "Accel Button")
        accelButton.name = "Accel"
        accelButton.scale(to: CGSize(width: 170, height: 125))
        accelButton.position = CGPoint(x: -300, y: -200)
        accelButton.zPosition = 5.0
        Button.addChild(accelButton)
        
        // Jump Button
        jumpButton = SKSpriteNode(imageNamed: "Jump Button")
        jumpButton.name = "Jump"
        jumpButton.scale(to: CGSize(width: 180, height: 125))
        jumpButton.position = CGPoint(x: 480, y: -200)
        jumpButton.zPosition = 5.0
        Button.addChild(jumpButton)
        
        // Item Button
        itemButton = SKSpriteNode(imageNamed: "Item Button")
        itemButton.name = "Item"
        itemButton.scale(to: CGSize(width: 100, height: 100))
        itemButton.position = CGPoint(x: 300, y: -200)
        itemButton.zPosition = 5.0
        Button.addChild(itemButton)
        
        // Item Image
        itemImage = SKSpriteNode(imageNamed: "Item Button")
        itemImage.name = "Item Image"
        itemImage.scale(to: CGSize(width: 100, height: 100))
        itemImage.position = CGPoint(x: itemButton.frame.midX, y: itemButton.frame.midY)
        itemImage.zPosition = 5.0
        Button.addChild(itemImage)
        
        // Pause Button
        pauseButton = SKSpriteNode(imageNamed: "Pause")
        pauseButton.name = "Pause"
        pauseButton.scale(to: CGSize(width: 30, height: 35))
        pauseButton.position = CGPoint(x: 530, y: 240)
        pauseButton.zPosition = 5.0
        Button.addChild(pauseButton)
    }
    
    // HUD Node 설정
    private func setupHUDNode() {
        // HUD
        HUD = SKNode()
        HUD.name = "HUD"
        HUD.zPosition = 5.0
        addChild(HUD)
        
        // Location Bar
        locationBar = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 100, height: 15), cornerRadius: 5)
        locationBar.name = "Location Bar"
        locationBar.fillColor = .deliveryrunRed!
        locationBar.lineWidth = 1
        locationBar.strokeColor = .white
        locationBar.position = CGPoint(x: 0, y: 225)
        locationBar.zPosition = 5.0
        locationBarLength = locationBar.frame.width - 100.0
        HUD.addChild(locationBar)
        
        // Start Line Short
        startLineShort = SKSpriteNode(imageNamed: "Finish Line Short")
        startLineShort.scale(to: CGSize(width: 10, height: 15))
        startLineShort.position = CGPoint(x: locationBar.frame.minX + 50, y: locationBar.frame.midY)
        startLineShort.zPosition = 5.0
        HUD.addChild(startLineShort)
        
        // Finish Line Short
        finishLineShort = SKSpriteNode(imageNamed: "Finish Line Short")
        finishLineShort.scale(to: CGSize(width: 10, height: 15))
        finishLineShort.position = CGPoint(x: locationBar.frame.maxX - 50, y: locationBar.frame.midY)
        finishLineShort.zPosition = 5.0
        HUD.addChild(finishLineShort)
        
        // Player Location
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: -10.0))
        path.addLine(to: CGPoint(x: 12.5, y: 10.0))
        path.addLine(to: CGPoint(x: -12.5, y: 10.0))
        path.addLine(to: CGPoint(x: 0.0, y: -10.0))
        playerLocation = SKShapeNode(path: path.cgPath)
        playerLocation.fillColor = .deliveryrunYellow!
        playerLocation.strokeColor = .white
        playerLocation.lineWidth = 2
        playerLocation.position.y = 240
        playerLocation.zPosition = 5.0
        HUD.addChild(playerLocation)
        
        // Timer Icon
        timerIcon = SKSpriteNode(imageNamed: "Timer")
        timerIcon.name = "Timer Icon"
        timerIcon.scale(to: CGSize(width: 45, height: 60))
        timerIcon.position = CGPoint(x: locationBar.frame.minX - 150, y: locationBar.frame.midY)
        timerIcon.zPosition = 5.0
        HUD.addChild(timerIcon)
        
        // Timer Label
        timerText = SKLabelNode(fontNamed: "BMJUAOTF")
        timerText.name = "Timer Label"
        timerText.fontSize = 40
        timerText.fontColor = .red
        timerText.verticalAlignmentMode = .center
        timerText.horizontalAlignmentMode = .center
        timerText.position = CGPoint(x: timerIcon.frame.maxX + 50, y: locationBar.frame.midY - 8)
        timerText.zPosition = 5.0
        HUD.addChild(timerText)
        
        // Speeder Icon
        speederIcon = SKSpriteNode(imageNamed: "speed")
        speederIcon.name = "Speeder Label"
        speederIcon.scale(to: CGSize(width: 50, height: 60))
        speederIcon.position = CGPoint(x: -80, y: -200)
        speederIcon.zPosition = 5.0
        HUD.addChild(speederIcon)
        
        // Speeder Label
        speederText = SKLabelNode(fontNamed: "BMJUAOTF")
        speederText.name = "Speed Label"
        speederText.fontSize = 40
        speederText.fontColor = .deliveryrunMint
        speederText.verticalAlignmentMode = .center
        speederText.horizontalAlignmentMode = .center
        speederText.position = CGPoint(x: speederIcon.frame.maxX + 80, y: -200)
        speederText.zPosition = 5.0
        HUD.addChild(speederText)
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
            
            jumpAction = jumpButton.frame.contains(location)
            accelAction = accelButton.frame.contains(location)
            breakAction = breakButton.frame.contains(location)
            itemAction = itemButton.frame.contains(location)
            
            if pauseButton.frame.contains(location) {
                isGamePaused = true
                cameraNode!.addChild(pauseScreen)
                pauseScreen.skView = view
                pauseScreen.gameScene = self
            }
            
            if jumpAction {
                playerStateMachine.enter(JumpingState.self)
            }
            if accelAction {
                acceling(deltaTime: 0)
            }
            if breakAction {
                breaking(deltaTime: 0)
            }
            if itemAction {
                if itemImage.name == "Drink" {
                    playerSpeed += 10
                    itemImage.texture = SKTexture(imageNamed:"Item Button")
                    itemImage.scale(to: CGSize(width: 100, height: 100))
                    itemImage.name = "Item Image"
                }
                else if itemImage.name == "Wing" {
                    print("Wing")
                    itemImage.texture = SKTexture(imageNamed:"Item Button")
                    itemImage.scale(to: CGSize(width: 100, height: 100))
                    itemImage.name = "Item Image"
                }
                else if itemImage.name == "Star" {
                    playerStateMachine.enter(StarState.self)
                    itemImage.texture = SKTexture(imageNamed:"Item Button")
                    itemImage.scale(to: CGSize(width: 100, height: 100))
                    itemImage.name = "Item Image"
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            jumpAction = jumpButton.frame.contains(location)
            accelAction = accelButton.frame.contains(location)
            breakAction = breakButton.frame.contains(location)
            itemAction = itemButton.frame.contains(location)
            
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
    
    func endGame() {
        self.sceneDelegate?.popupGameOver()
        self.sceneDelegate?.getTimeRap(recordTime: passedTime)
    }
}


// MARK: Game Loop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        if !isGamePaused {
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
                playerStateMachine.enter(JumpingState.self)
            } else if accelAction {
                acceling(deltaTime: deltaTime)
            } else if breakAction {
                breaking(deltaTime: deltaTime)
            } else {
                running(deltaTime: deltaTime)
            }
            
            // 도착 시 게임 종료
            if player.position.x >= endPoint && !(gameOver) {
                endGame()
                gameOver = true
            }
        }
        
        // Node 위치 지정
        cameraNode?.position.x = player.position.x + 300
        Button.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
        HUD.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
        playerLocation.position.x = ((player.position.x / endPoint) * locationBarLength) - locationBarLength / 2.0
        
        // Label Text 설정
        timerText.text = String(format: "%D", passedTime)
        speederText.text = String(format: "%d km/h", Int(playerSpeed * 6))
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
        
        if collision.matches(.player, .ground) {
            playerStateMachine.enter(LandingState.self)
        }
        
        if collision.matches(.player, .reward) {
            // Drink 획득
            if contact.bodyA.node?.name == "Drink Bubble" {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                contact.bodyA.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Drink Item")
                    itemImage.scale(to: CGSize(width: 45, height: 75))
                    itemImage.name = "Drink"
                }
            }
            else if contact.bodyB.node?.name == "Drink Bubble" {
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Drink Item")
                    itemImage.scale(to: CGSize(width: 45, height: 75))
                    itemImage.name = "Drink"
                }
            }
            
            // Wing 획득
            if contact.bodyA.node?.name == "Wing Bubble" {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                contact.bodyA.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Wing Item")
                    itemImage.scale(to: CGSize(width: 90, height: 77))
                    itemImage.name = "Wing"
                }
            }
            else if contact.bodyB.node?.name == "Wing Bubble" {
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Wing Item")
                    itemImage.scale(to: CGSize(width: 90, height: 77))
                    itemImage.name = "Wing"
                }
            }
            
            // Star 획득
            if contact.bodyA.node?.name == "Star Bubble" {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                contact.bodyA.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Star Item")
                    itemImage.scale(to: CGSize(width: 70, height: 70))
                    itemImage.name = "Star"
                }
            }
            else if contact.bodyB.node?.name == "Star Bubble" {
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.removeFromParent()
                
                if itemImage.name == "Item Image" {
                    itemImage.texture = SKTexture(imageNamed: "Star Item")
                    itemImage.scale(to: CGSize(width: 70, height: 70))
                    itemImage.name = "Star"
                }
            }
        }
    }
}
