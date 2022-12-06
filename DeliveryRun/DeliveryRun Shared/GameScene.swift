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
    let soundSetting = Sound.shared
    
    
    var stageNumber:Int = 1
    var viewController: GameViewController!
    let userDefault = UserDefaultData.shared
    
    //Tracking Data
    var jumpData:Int = 0
    var breakData:Int = 0
    var collisionData:Int = 0
    var previousTimeRecord:Double = 0.00
    var isClear:Bool = false
    
    // Player
    let player = SKSpriteNode(imageNamed: "player0")
    
    // Buttons
    var Button: SKNode!
    var jumpButton: SKSpriteNode!
    var accelButton: SKSpriteNode!
    var breakButton: SKSpriteNode!
    var itemButton: SKSpriteNode!
    var itemImage: SKSpriteNode!
    var pauseButton: SKSpriteNode!
    
    // HUD
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
    
    // Story
    var Story: SKNode!
    var storyBackground: SKShapeNode!
    var storyText: SKLabelNode!
    
    // Boolean
    private var jumpAction = false
    private var accelAction = false
    private var breakAction = false
    private var itemAction = false
    private var storyAction = false
    var startAction = false
    var pauseAction = false
    var stealAction = false
    var isGameOver = false
    
    // CameraNode
    var cameraNode: SKCameraNode?
    
    // Player State
    var playerStateMachine : GKStateMachine!
    
    // Variables
    var timer = Timer()
    
    var catSign:SKNode!
    var catAnimation = [SKTexture]()
    
    let endTime = 100
    var elapsedTime = 0
    var playerSpeed = 3.0
    let maxSpeed = 10.0
    let minSpeed = 1.0
    var endPoint = 20000.0
    
    @objc func updateTimer() {
        if endTime > elapsedTime {
            elapsedTime += 1
        } else {
            timer.invalidate()
        }
    }
    
    //MARK: Scene 실행 시
    override func didMove(to view: SKView) {
        
        print("111",userDefault.backgroundMusic)
        print("222", userDefault.gameSound)
        
        if userDefault.backgroundMusic {
            soundSetting.stopBackground()
            soundSetting.playBackground(backgroundName: "ingame")
        }
        
        if userDefault.gameSound {
            soundSetting.playgameSound(gameSoundName: "start")
        } else {
            soundSetting.stopGameSound()
        }
        
        
        // StageNumber
        self.stageNumber = userDefault.stageNumber
        print("StageNumber",stageNumber)
        //Add catSign
        
        catSign = childNode(withName: "CatSign")
        stealAction = true
        let catTexture = SKTextureAtlas(named:"CatAnimation")
        
        for index in 0..<catTexture.textureNames.count {
            let textureName = "cat" + String(index)
            catAnimation.append(catTexture.textureNamed(textureName))
        }
        
        // UserDefault Tracking Data
        UserDefaultData.findPath()
        self.jumpData = userDefault.defaults.integer(forKey:"JumpData")
        self.breakData = userDefault.defaults.integer(forKey:"BreakData")
        self.collisionData = userDefault.defaults.integer(forKey:"CollisionData")
        
        
        // Physical Delegate
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
        jumpButton.position = CGPoint(x: 450, y: -200)
        jumpButton.zPosition = 5.0
        Button.addChild(jumpButton)
        
        // Item Button
        itemButton = SKSpriteNode(imageNamed: "Item Button")
        itemButton.name = "Item"
        itemButton.scale(to: CGSize(width: 100, height: 100))
        itemButton.position = CGPoint(x: 280, y: -200)
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
        pauseButton.position = CGPoint(x: 530, y: 225)
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
        locationBar = SKShapeNode(rectOf: CGSize(width: 740, height: 15), cornerRadius: 5)
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
        speederIcon.position = CGPoint(x: -70, y: -200)
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
    
    // Story Node 설정
    private func setupStoryNode() {
        // Story
        Story = SKNode()
        Story.name = "Story"
        Story.zPosition = 6.0
        addChild(Story)
        
        // Story Background
        storyBackground = SKShapeNode(rectOf: CGSize(width: 1100, height: 200), cornerRadius: 10)
        storyBackground.name = "Story Background"
        storyBackground.fillColor = .black.withAlphaComponent(0.8)
        storyBackground.lineWidth = 1
        storyBackground.strokeColor = .white
        storyBackground.position = CGPoint(x: 0, y: -170)
        storyBackground.zPosition = 6.0
        Story.addChild(storyBackground)
        
        // Story Label
        storyText = SKLabelNode(fontNamed: "BMJUAOTF")
        storyText.name = "Story Label"
        storyText.fontSize = 30
        storyText.fontColor = .white
        storyText.verticalAlignmentMode = .center
        storyText.horizontalAlignmentMode = .left
        storyText.position = CGPoint(x: storyBackground.frame.minX + 30, y: storyBackground.frame.maxY - 30)
        storyText.zPosition = 6.0
        Story.addChild(storyText)
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
            jumpAction = jumpButton.frame.contains(location)
            accelAction = accelButton.frame.contains(location)
            breakAction = breakButton.frame.contains(location)
            itemAction = itemButton.frame.contains(location)
            pauseAction = pauseButton.frame.contains(location)
            
            if pauseAction {
                self.viewController.pauseBackView.isHidden = false
                self.view?.isPaused = true
            }
            if jumpAction {
                jumpData += 1
            }
            if breakAction {
                breakData += 1
            }
            
            if itemAction {
                if itemImage.name == "Drink" {
                    playerSpeed += 10
                    itemImage.texture = SKTexture(imageNamed:"Item Button")
                    itemImage.scale(to: CGSize(width: 100, height: 100))
                    itemImage.name = "Item Image"
                }
                else if itemImage.name == "Wing" {
                    jumpButton.texture = SKTexture(imageNamed: "Fly Button")
                    jumpButton.name = "Fly"
                    Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
                        self.jumpButton.texture = SKTexture(imageNamed: "Jump Button")
                        self.jumpButton.name = "Jump"
                    }
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
                jumpAction = false
            }
            if accelAction {
                accelAction = false
            }
            if breakAction {
                breakAction = false
            }
        }
    }
}

// MARK: Game Action
extension GameScene {
    // Player Intercation Function
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
    
    func usualDamage() {
        playerSpeed = minSpeed
        playerStateMachine.enter(DamageState.self)
    }
    
    func emrgeCat() {
        if player.position.x >= catSign.position.x {
            if player.position.x <= catSign.position.x + 1000 && stealAction{
                stealAction = false
                createCat()
            }
        }
    }
    
    // Game UI Function
    func arrival(timeRecord:Double) {
        self.viewController.endBackView.isHidden = false
        self.viewController.nowRecordLabel.text = String(format: "현재기록 : %.2f", timeRecord)
        Button.removeFromParent()
        HUD.removeFromParent()
        userDefault.endGameSaveData(jumpData: self.jumpData, breakData: self.breakData, collisionData: self.collisionData, timeRecord: Double(elapsedTime), stageNumber: stageNumber)
    }
}


// MARK: Game Loop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        if !storyAction {
            // Player 이동
            let deltaTime = 1.0
            let diplacement = CGVector(dx: deltaTime * playerSpeed, dy: 0)
            let move = SKAction.move(by: diplacement, duration: 0)
            player.run(SKAction.sequence([move]))
            
            // Player Action
            if jumpAction {
                if jumpButton.name == "Fly" {
                    player.physicsBody?.applyForce(CGVector(dx: 0, dy: 350))
                }
                else {
                    playerStateMachine.enter(JumpingState.self)
                }
            }
            if accelAction {
                acceling(deltaTime: deltaTime)
            } else if breakAction {
                breaking(deltaTime: deltaTime)
            } else {
                running(deltaTime: deltaTime)
            }
        }
            
        // 도착 시 게임 종료
        if player.position.x >= endPoint && !(isGameOver) {
            arrival(timeRecord: Double(elapsedTime))
            isGameOver = true
        }
        
        // Node 위치 지정
        cameraNode?.position.x = player.position.x + 300
        Button.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
        HUD.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
        playerLocation.position.x = ((player.position.x / endPoint) * locationBarLength) - locationBarLength / 2.0
        
        // Label Text 설정
        timerText.text = String(format: "%D", elapsedTime)
        speederText.text = String(format: "%d km/h", Int(playerSpeed * 6))
    }
}


// MARK: Collision
extension GameScene: SKPhysicsContactDelegate {
    struct Collision {
        enum Masks: Int {
            case damage, player, reward, ground, ending, interaction
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
        
        // MARK: - 특수 장애물 속성 부여
        if collision.matches(.player, .damage) {
            // Disable Fly Button
            if jumpButton.name == "Fly" {
                jumpButton.texture = SKTexture(imageNamed: "Jump Button")
                jumpButton.name = "Jump"
            }
            
            // Speed Bump
            if contact.bodyA.node?.name == "Speed Bump" {
                playerStateMachine.enter(JumpingState.self)
            } else if contact.bodyB.node?.name == "Speed Bump" {
                playerStateMachine.enter(JumpingState.self)
            }
            
            // Police
            if contact.bodyA.node?.name == "Police" {
                storyAction = true
                Button.removeFromParent()
                setupStoryNode()
                Story.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
                storyText.text = "단속 중입니다. 잠시 정차해주세요."
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [self] _ in
                    storyText.text = "통과하셔도 됩니다."
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [self] _ in
                        contact.bodyA.node?.removeFromParent()
                        Story.removeFromParent()
                        setupButtonNode()
                        storyAction = false
                    }
                }
            }
            else if contact.bodyB.node?.name == "Police" {
                storyAction = true
                Button.removeFromParent()
                setupStoryNode()
                Story.position = CGPoint(x: (cameraNode!.position.x), y: (cameraNode!.position.y))
                storyText.text = "단속 중입니다. 잠시 정차해주세요."
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [self] _ in
                    storyText.text = "통과하셔도 됩니다."
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [self] _ in
                        contact.bodyB.node?.removeFromParent()
                        Story.removeFromParent()
                        setupButtonNode()
                        storyAction = false
                    }
                }
            }
            else {
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
                usualDamage()
            }
            collisionData += 1
        }
        
        if collision.matches(.player, .interaction) {
            if contact.bodyA.node?.name == "Cat" {
                stealAction = false
            } else if contact.bodyB.node?.name == "Cat" {
                stealAction = false
            }
        }
        
        
        if collision.matches(.player, .ground) {
            if jumpButton.name == "Fly" {
                jumpButton.texture = SKTexture(imageNamed: "Jump Button")
                jumpButton.name = "Jump"
            }
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

// MARK: Interaction
extension GameScene {

    func createCat() {

        let node = SKSpriteNode(imageNamed: "cat0")
        node.name = "Cat"
        node.position = CGPoint(x: player.position.x + 400.0, y:player.position.y + 100.0)
        node.anchorPoint = CGPoint(x: 0.5, y:1)
        node.scale(to: CGSize(width: 150, height: 150))
        node.zPosition = 5
        
        node.run(SKAction.repeatForever(SKAction.animate(with: catAnimation, timePerFrame: 0.3)))

        let physicalBody = SKPhysicsBody(circleOfRadius: 30)
        node.physicsBody = physicalBody

        physicalBody.categoryBitMask = Collision.Masks.interaction.bitmask
        physicalBody.collisionBitMask = Collision.Masks.player.bitmask
        physicalBody.fieldBitMask = Collision.Masks.ground.bitmask
        physicalBody.contactTestBitMask = Collision.Masks.player.bitmask

        physicalBody.pinned = true
        physicalBody.allowsRotation = false
        physicalBody.restitution = 0.2
        physicalBody.friction = 10

        addChild(node)

    }
    func removeCat() {
        
    }
}
