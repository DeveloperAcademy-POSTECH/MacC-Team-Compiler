//
//  HUD.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/02.
//

import SpriteKit

// MARK: - Status Bar
class StatusBar: SKNode {
    // Nodes
    private var locationBar: SKShapeNode!
    
    // Initialize
    override init() {
        super.init()
        
        // Location Bar
        locationBar = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width - 300, height: 12), cornerRadius: 5)
        locationBar.fillColor = .deliveryrunRed!
        locationBar.lineWidth = 1
        locationBar.strokeColor = .white
        locationBar.position = CGPoint(x: 0, y: 164)
        locationBar.zPosition = 5.0
        addChild(locationBar)
        
        // Location Line
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Pause Screen
class PauseScreen: SKNode {
    // Nodes
    private var pauseBackground: SKShapeNode!
    private var pauseBase: SKShapeNode!
    private var titleLabel: SKLabelNode!
    private var playButton: SKSpriteNode!
    private var restartButton: SKSpriteNode!
    private var homeButton: SKSpriteNode!
    
    var gameScene: GameScene?
    var skView: SKView!
    
    // Boolean
    private var isPlay = false {
        didSet {
            updateBtn(node:playButton, event: isPlay)
        }
    }
    private var isRestart = false {
        didSet {
            updateBtn(node:restartButton, event: isRestart)
        }
    }
    private var isHome = false {
        didSet {
            updateBtn(node:homeButton, event: isHome)
        }
    }
    
    // Initialize
    override init() {
        super.init()
        appearPause()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        
        if node.name == "Resume" && !isPlay {
            isPlay = true
        }
        if node.name == "Restart" && !isRestart {
            isRestart = true
        }
        if node.name == "Home" && !isHome {
            isHome = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if isPlay {
            isPlay = false
            gameScene?.isGamePaused = false
            self.removeFromParent()
        }
        if isRestart {
//            if let _ = gameScene {
//                let scene = GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
//                scene.scaleMode = .aspectFill
//                skView.presentScene(scene, transition: .doorway(withDuration: 1))
//            }
            isRestart = false
        }
        if isHome {
//            gameScene?.sceneDelegate?.changeView()
//            isHome = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let touch = touches.first else { return }
        
        if let parent = playButton.parent {
            isPlay = playButton.contains(touch.location(in: parent))
        }
        if let parent = restartButton.parent {
            isRestart = restartButton.contains(touch.location(in: parent))
        }
        if let parent = homeButton.parent {
            isHome = homeButton.contains(touch.location(in: parent))
        }
    }
    
    private func updateBtn(node: SKNode, event: Bool) {
        var alpha: CGFloat = 1.0
        if event {
            alpha = 0.5
        }
        node.run(.fadeAlpha(to: alpha, duration: 0.1))
    }
    
    // Pause Setup
    private func appearPause() {
        isUserInteractionEnabled = true
        
        // Background
        pauseBackground = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        pauseBackground.fillColor = UIColor.white.withAlphaComponent(0.6)
        pauseBackground.zPosition = 10.0
        addChild(pauseBackground)
        
        // Pause Background
        pauseBase = SKShapeNode(rectOf: CGSize(width: 270, height: 135), cornerRadius: 10)
        pauseBase.fillColor = UIColor.deliveryrunBlack!.withAlphaComponent(0.6)
        pauseBase.zPosition = 20.0
        pauseBase.position = CGPoint(x: pauseBackground.frame.midX, y: pauseBackground.frame.midY)
        addChild(pauseBase)
        
        // Pause Title
        titleLabel = SKLabelNode(fontNamed: "BMJUAOTF")
        titleLabel.fontSize = 30
        titleLabel.text = "PAUSE"
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: pauseBase.frame.midX, y: pauseBase.frame.midY + 35)
        titleLabel.zPosition = 25.0
        addChild(titleLabel)
        
        // Play Button
        playButton = SKSpriteNode(imageNamed: "Play")
        playButton.name = "Resume"
        playButton.position = CGPoint(x: pauseBase.frame.midX - (pauseBase.frame.width / 3) + 5, y: pauseBase.frame.midY - 15)
        playButton.zPosition = 30.0
        addChild(playButton)
        
        // Restart Button
        restartButton = SKSpriteNode(imageNamed: "Restart")
        restartButton.name = "Restart"
        restartButton.position = CGPoint(x: pauseBase.frame.midX, y: pauseBase.frame.midY - 15)
        restartButton.zPosition = 30.0
        addChild(restartButton)
        
        // Home Button
        homeButton = SKSpriteNode(imageNamed: "Home")
        homeButton.name = "Home"
        homeButton.position = CGPoint(x: pauseBase.frame.midX + (pauseBase.frame.width / 3) - 5, y: pauseBase.frame.midY - 15)
        homeButton.zPosition = 30.0
        addChild(homeButton)
    }
}
