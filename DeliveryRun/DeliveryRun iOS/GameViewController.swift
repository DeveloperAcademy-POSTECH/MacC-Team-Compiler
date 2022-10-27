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
class GameViewController: UIViewController, GameSceneDelegate{
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    var timeRap = 0
    
    func popupGameOver() {
        popupView.isHidden = false
    }

    func getTimeRap(recordTime paasedTime:Int) {
        timeRap = paasedTime
        recordLabel.text = String(format: "Your Record %D's", timeRap)
    }
    
    override func viewDidLoad() {
        popupView.isHidden = true
        super.viewDidLoad()
        
        
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Root 노드 생성
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.viewController = self
                
                // Set the scale mode to scale to fit the window 화면에 Scene파일 맞추기
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    
                    // 모든 노드가 Z축 활성화
                    view.ignoresSiblingOrder = false
                    
                    // Node갯수 및 Fps 보기
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }
    
}
