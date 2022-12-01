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
        if let view = self.view as! SKView?, let gameScene = view.scene as?
            GameScene {
            gameScene.restartGame()
        }
        
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
    
    
    @IBAction func replayPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.reTryGame()
        }
        
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
    
    @IBAction func goStagePressed(_ sender: UIButton) {
        let stage = UIStoryboard.init(name: "Stage", bundle: nil)
        guard let StageViewController = stage.instantiateViewController(identifier: "StageViewController") as? StageViewController else { return }
        StageViewController.modalPresentationStyle = .fullScreen
        self.present(StageViewController, animated: false, completion: nil)
        self.performSegue(withIdentifier: "Stage", sender: self)
    }
    
    @IBAction func goRobbyPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as?
            GameScene {
            gameScene.removeFromParent()
            let robby = UIStoryboard.init(name: "Robby", bundle: nil)
                    guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "RobbyViewController")as? RobbyViewController else {return}
            RobbyViewController.modalPresentationStyle = .fullScreen
                    self.present(RobbyViewController, animated: false, completion: nil)
        }
    }
}

