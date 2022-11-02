//
//  HUD.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/02.
//

import SpriteKit

// Pause Screen
class PauseScreen:SKNode {
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
        
        // 일시정지 배경
        pauseBase = SKShapeNode(rectOf: CGSize(width: 270, height: 135), cornerRadius: 10)
        pauseBase.fillColor = UIColor.deliveryrunBlack!.withAlphaComponent(0.6)
        pauseBase.zPosition = 20.0
        pauseBase.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        addChild(pauseBase)
        
        // 일시정지 창 제목
        titleLabel = SKLabelNode(fontNamed: "BMJUAOTF")
        titleLabel.fontSize = 30
        titleLabel.text = "PAUSE"
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: pauseBase.frame.midX, y: pauseBase.frame.midY + 35)
        titleLabel.zPosition = 25.0
        addChild(titleLabel)
        
        // 플레이 버튼
        playButton = SKSpriteNode(imageNamed: "Play")
        playButton.position = CGPoint(x: pauseBase.frame.midX - (pauseBase.frame.width / 3) + 5, y: pauseBase.frame.midY - 15)
        playButton.zPosition = 30.0
        addChild(playButton)
        
        // 다시 시작 버튼
        restartButton = SKSpriteNode(imageNamed: "Restart")
        restartButton.position = CGPoint(x: pauseBase.frame.midX, y: pauseBase.frame.midY - 15)
        restartButton.zPosition = 30.0
        addChild(restartButton)
        
        // 홈 버튼
        homeButton = SKSpriteNode(imageNamed: "Home")
        homeButton.position = CGPoint(x: pauseBase.frame.midX + (pauseBase.frame.width / 3) - 5, y: pauseBase.frame.midY - 15)
        homeButton.zPosition = 30.0
        addChild(homeButton)
    }
}
