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
    let userDefaultData = UserDefaultData()
    var timeRap = 0
    var storyNumber:Int = 0
    
    // Pause Screen IBOutlet
    @IBOutlet weak var pauseBackView: UIView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var pauseLabel: UILabel!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pause Screen
        pauseBackView.alpha = 1.0
        pauseBackView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        pauseView.backgroundColor = .deliveryrunBlack!.withAlphaComponent(0.8)
        pauseView.layer.cornerRadius = 10
        pauseView.layer.borderWidth = 1
        pauseView.layer.borderColor = UIColor.white.cgColor
        
        pauseLabel.text = "PAUSE"
        pauseLabel.font = UIFont(name: "BMJUAOTF", size: 30)
        pauseLabel.textAlignment = .center
        pauseLabel.textColor = .white
        
        pauseBackView.isHidden = true
        
        arrivalView.isHidden = true
        
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
    
    @IBOutlet weak var arrivalView: UIView!
    
    @IBOutlet weak var nextTextButton: UIButton!
    @IBOutlet weak var storyView: StoryView!
    @IBOutlet weak var PresentRecord: UILabel!
    @IBOutlet weak var PreviousRecord: UILabel!
    func getTimeRap(recordTime paasedTime:Int) {
        timeRap = paasedTime
    }
    
    // MARK: - Pause Screen IBAction
    @IBAction func replayPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            pauseBackView.isHidden = true
            gameScene.view?.isPaused = false
        }
    }
    
    @IBAction func restartPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            pauseBackView.isHidden = true
            gameScene.view?.isPaused = false
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
    
    @IBAction func homePressed(_ sender: UIButton) {
        let stage = UIStoryboard.init(name: "Stage", bundle: nil)
        guard let StageViewController = stage.instantiateViewController(identifier: "StageViewController") as? StageViewController else { return }
        StageViewController.modalPresentationStyle = .fullScreen
        self.present(StageViewController, animated: false, completion: nil)
    }
    
    @IBAction func retryPressed(_ sender: UIButton) {
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
    }
    
    
    @IBAction func nextTextPressed(_ sender: UIButton) {
        if let view = self.view as! SKView?, let gameScene = view.scene as? GameScene {
            gameScene.isPaused = true
            if storyNumber <= 2{
                storyNumber += 1
            } else {
                storyNumber = 3
            }
            storyView.storyTextLabel.text = storyTexts[storyNumber]
            if storyNumber == 3 {
                storyView.isHidden = true
                gameScene.isPaused = false
                nextTextButton.isHidden = true
            }
        }
    }
}

let storyTexts = ["시작", "텍스트2", "텍스트3","끝"]
