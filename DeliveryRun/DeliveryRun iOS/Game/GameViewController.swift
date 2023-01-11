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
    
    let userDefault = UserDefaultData.shared
    let backgroundSetting = BackgroundSound.shared
    
    var chapterNumber:Int = 0
    var stageNumber:Int = 0
    var targetRecord: Double = 0.00
    
    // Pause Screen IBOutlet
    @IBOutlet weak var pauseBackView: UIView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var pauseLabel: UILabel!
    
    // End Screen IBOutlet
    @IBOutlet weak var endBackView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var endTitleLabel: UILabel!
    @IBOutlet weak var endResultStar: UIImageView!
    @IBOutlet weak var targetRecordLabel: UILabel!
    @IBOutlet weak var nowRecordLabel: UILabel!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chapterNumber = userDefault.getChapterNumber()
        stageNumber = userDefault.getStageNumber()
        self.targetRecord = userDefault.getTargetRecord(chapterNumber: chapterNumber, stageNumber: stageNumber)
        endResultStar.image = UIImage(named: "Result Star 0")
        
        // Pause Screen
        pauseView.backgroundColor = .deliveryrunPurple
        pauseView.layer.cornerRadius = 10
        pauseView.layer.borderWidth = 1
        pauseView.layer.borderColor = UIColor.white.cgColor
        
        pauseLabel.text = "PAUSE"
        pauseLabel.font = UIFont(name: "BMJUAOTF", size: 30)
        pauseLabel.textAlignment = .center
        pauseLabel.textColor = .white
        
        pauseBackView.alpha = 1.0
        pauseBackView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        pauseBackView.isHidden = true
        
        
        // End Screen
        endBackView.alpha = 1.0
        endBackView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        endBackView.isHidden = true
        
        endView.backgroundColor = .deliveryrunPurple
        endView.layer.cornerRadius = 10
        endView.layer.borderWidth = 1
        endView.layer.borderColor = UIColor.white.cgColor
        
        endTitleLabel.text = "배달 완료"
        endTitleLabel.font = UIFont(name: "BMJUAOTF", size: 40)
        endTitleLabel.textAlignment = .center
        endTitleLabel.textColor = .white
        
        targetRecordLabel.text = String(format: "목표 기록 : %.2f", self.targetRecord)
        targetRecordLabel.font = UIFont(name: "BMJUAOTF", size: 20)
        targetRecordLabel.textAlignment = .center
        targetRecordLabel.textColor = .white
        
        nowRecordLabel.font = UIFont(name: "BMJUAOTF", size: 20)
        nowRecordLabel.textAlignment = .center
        nowRecordLabel.textColor = .white
        
        // Present the scene
        if let scene = GameScene(fileNamed: String(format: "Stage %D-%D", chapterNumber,stageNumber)) {
            scene.scaleMode = .aspectFill
            scene.viewController = self
            if let view = self.view as! SKView? {
                view.presentScene(scene)
                view.ignoresSiblingOrder = false
            }
        }
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
        if let scene = GameScene(fileNamed: String(format: "Stage %D-%D", chapterNumber,stageNumber)) {
            scene.scaleMode = .aspectFill
            scene.viewController = self
            if let view = self.view as! SKView? {
                view.presentScene(scene)
                view.ignoresSiblingOrder = false
            }
        }
    }
    
    @IBAction func homePressed(_ sender: UIButton) {
        backgroundSetting.backgroundSoundOff()
        if userDefault.backgroundMusic {
            backgroundSetting.playSound(soundName: "BackgroundMusic")
        }
        let stage = UIStoryboard.init(name: "Stage", bundle: nil)
        guard let StageViewController = stage.instantiateViewController(identifier: "StageViewController") as? StageViewController else { return }
        StageViewController.modalPresentationStyle = .fullScreen
        self.present(StageViewController, animated: false, completion: nil)
    }
    
    
    // MARK: - End Screen IBAction
    @IBAction func retryPressed(_ sender: UIButton) {
        endBackView.isHidden = true
        if let scene = GameScene(fileNamed: String(format: "Stage %D-%D", chapterNumber,stageNumber)) {
            scene.scaleMode = .aspectFill
            scene.viewController = self
            if let view = self.view as! SKView? {
                view.presentScene(scene)
                view.ignoresSiblingOrder = false
            }
        }
    }
    
}

