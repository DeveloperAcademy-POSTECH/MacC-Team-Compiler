//
//  HUD.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/02.
//

import SpriteKit

// Pause Screen
class PauseScreen:SKNode {
    private var pauseBackground: SKShapeNode!
    private var pauseBase: SKShapeNode!
    private var titleLabel: SKLabelNode!
    private var playButton: SKSpriteNode!
    private var restartButton: SKSpriteNode!
    private var homeButton: SKSpriteNode!
    
    // Initialize
    override init() {
        super.init()
        appearPause()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func appearPause() {
        isUserInteractionEnabled = true
        
        // Background
        pauseBackground = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        pauseBackground.fillColor = UIColor.white.withAlphaComponent(0.6)
        pauseBackground.zPosition = 10.0
        pauseBackground.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        addChild(pauseBackground)
        
        // Pause Background
        pauseBase = SKShapeNode(rectOf: CGSize(width: 270, height: 135), cornerRadius: 10)
        pauseBase.fillColor = UIColor.deliveryrunBlack!.withAlphaComponent(0.6)
        pauseBase.zPosition = 20.0
        pauseBase.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
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
        playButton.position = CGPoint(x: pauseBase.frame.midX - (pauseBase.frame.width / 3) + 5, y: pauseBase.frame.midY - 15)
        playButton.zPosition = 30.0
        addChild(playButton)
        
        // Restart Button
        restartButton = SKSpriteNode(imageNamed: "Restart")
        restartButton.position = CGPoint(x: pauseBase.frame.midX, y: pauseBase.frame.midY - 15)
        restartButton.zPosition = 30.0
        addChild(restartButton)
        
        // Home Button
        homeButton = SKSpriteNode(imageNamed: "Home")
        homeButton.position = CGPoint(x: pauseBase.frame.midX + (pauseBase.frame.width / 3) - 5, y: pauseBase.frame.midY - 15)
        homeButton.zPosition = 30.0
        addChild(homeButton)
    }
}
