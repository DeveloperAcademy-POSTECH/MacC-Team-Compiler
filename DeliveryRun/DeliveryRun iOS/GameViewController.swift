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

protocol GameSceneDelegate {
    func popupGameOver()
    func getTimeRap(recordTime:Int)
}

class GameViewController: UIViewController, GameSceneDelegate {
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var endButton: gameButton!
    var timeRap = 0
    
    func popupGameOver() {
        popupView.isHidden = false
    }

    func getTimeRap(recordTime paasedTime:Int) {
        timeRap = paasedTime
        recordLabel.text = String(format: "당신의 기록은 %D초 입니다.", timeRap)
    }
    
    override func viewDidLoad() {
        popupView.isHidden = true
        super.viewDidLoad()
        
        endButton.setTitle("돌아가기", for: .normal)
        
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Root 노드 생성
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.viewController = self
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    // 모든 노드가 Z축 활성화
                    view.ignoresSiblingOrder = false
                }
            }
        }
    }
    
}
