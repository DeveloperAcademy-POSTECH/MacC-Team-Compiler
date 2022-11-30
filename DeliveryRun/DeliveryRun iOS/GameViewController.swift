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
import AVFoundation

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        arrivalView.isHidden = true
        pauseView.isHidden = true
        super.viewDidLoad()
        if let scene = GKScene(fileNamed: "GameScene") {

            // Root 노드 생성
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.viewController = self
                sceneNode.scaleMode = .aspectFill

                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                }
            }
        }
    }
    
    let userDefaultData = UserDefaultData()
    var timeRap = 0
    
    @IBOutlet weak var arrivalView: UIView!
    @IBOutlet weak var pauseView: UIView!
    
    @IBOutlet weak var PresentRecord: UILabel!
    @IBOutlet weak var PreviousRecord: UILabel!
    func getTimeRap(recordTime paasedTime:Int) {
        timeRap = paasedTime
    }
    
    
    @IBAction func pausePlayPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.resume()
        }
        
    }
    
    @IBAction func pauseRePlayPressed(_ sender: UIButton) {
        
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.restartGame()
            if let newScene = GKScene(fileNamed: "GameScene") {
                if let newSceneNode = newScene.rootNode as! GameScene? {
                    newSceneNode.scaleMode = .aspectFill
                    newSceneNode.viewController = self
                    let animation = SKTransition.fade(withDuration: 2.0)
                    view.presentScene(newSceneNode, transition: animation)
                }
            }
        }
        
    }
    
    
    @IBAction func replayPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.reTryGame()
            if let newScene = GKScene(fileNamed: "GameScene") {
                if let newSceneNode = newScene.rootNode as! GameScene? {
                    newSceneNode.scaleMode = .aspectFill
                    newSceneNode.viewController = self
                    let animation = SKTransition.fade(withDuration: 2.0)
                    view.presentScene(newSceneNode, transition: animation)
                }
            }
        }
    }
    
}


//MARK: Update Custom 및 Scene CusTomObject 생성시 SKSeneDelegate SKViewDelgate 사용해야함

