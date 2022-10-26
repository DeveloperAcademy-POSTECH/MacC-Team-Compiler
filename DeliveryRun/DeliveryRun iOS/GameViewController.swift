//
//  GameViewController.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/10/11.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
        
//        // Sks 파일 불러오기 'GameScene.sks' as a GKScene.
//
//        if let scene = GKScene(fileNamed: "GameScene") {
//
//            // Root 노드 생성
//            if let sceneNode = scene.rootNode as! GameScene? {
//
//                // Set the scale mode to scale to fit the window 화면에 Scene파일 맞추기
//                sceneNode.scaleMode = .aspectFill
//
//                // Present the scene
//                if let view = self.view as! SKView? {
//                    view.presentScene(sceneNode)
//
//
//                    // 모든 노드가 Z축 활성화
//                    view.ignoresSiblingOrder = false
//
//                    // Node갯수 및 Fps 보기
//                    view.showsFPS = true
//                    view.showsNodeCount = true
//                }
//            }
//        }
    }
    
}
