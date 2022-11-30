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
        gameEndView.isHidden = true
        pauseView.isHidden = true
        super.viewDidLoad()
        if let scene = GKScene(fileNamed: "GameScene") {

            // Root 노드 생성
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.viewController = self
                sceneNode.scaleMode = .aspectFill
                sceneNode.statusPause = self.statusPause

                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                }
            }
        }
    }
    func pauseMenu() {
        pauseView.isHidden.toggle()
    }
    
    let userDefaultData = UserDefaultData()
    var stopValue: Bool = false
    var statusPause:Bool = false
    
    @IBOutlet weak var gameEndView: UIView!
    @IBOutlet weak var pauseView: UIView!
    var timeRap = 0
    
    func popupGameOver() {
        gameEndView.isHidden = false
    }
    
    func changeView() {
        self.present(StageViewController(), animated: false)
    }

    func getTimeRap(recordTime paasedTime:Int) {
        timeRap = paasedTime
        userDefaultData.setStage(myRecord: Double(timeRap), satr: 2, isLock: true)
    }
    
    
    @IBAction func pausePlayPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.gamePause()
        }
        
    }
    
    @IBAction func pauseRePlayPressed(_ sender: UIButton) {
        
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            if let newScene = GKScene(fileNamed: "GameScene") {
                if let newSceneNode = newScene.rootNode as! GameScene? {
                    newSceneNode.viewController = self
                    newSceneNode.scaleMode = .aspectFill
                    let animation = SKTransition.fade(withDuration: 1.0)
                    view.presentScene(newSceneNode, transition: animation)
                }
            }
        }
        
    }
    
    
    @IBAction func replayPressed(_ sender: UIButton) {
        
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Root 노드 생성
            if let sceneNode = scene.rootNode as! GameScene? {
//                sceneNode.viewController = self
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = false
                }
            }
        }
    }
    
}


//MARK: Update Custom 및 Scene CusTomObject 생성시 SKSeneDelegate SKViewDelgate 사용해야함

