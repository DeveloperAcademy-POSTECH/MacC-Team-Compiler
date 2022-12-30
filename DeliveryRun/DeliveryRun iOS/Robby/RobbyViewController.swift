//
//  GameViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/11.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class RobbyViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared
    let gameEffectSound = GameSound.shared
    let backgroundMusic = BackgroundSound.shared
    
    @IBOutlet weak var PlayerImage: UIImageView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var questView: QuestView!
    @IBOutlet weak var garageButton: CustomGameButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var questButton: UIButton!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultData.findPath()
        
        if userDefault.backgroundMusic {
            backgroundMusic.playSound(soundName: "BackgroundMusic")
        }
        
        PlayerImage.image = UIImage(named: userDefault.mySkin)
        
        garageButton.setTitle(" 차고", for: .normal)
        garageButton.setImage(UIImage(systemName: "car.fill"), for: .normal)
        
        startButton.setTitle("배달 준비", for: .normal)
        
        settingButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        settingButton.layer.shadowOpacity = 1
        settingButton.layer.shadowRadius = 20
        settingButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: settingButton.frame.width, height: settingButton.frame.height)).cgPath
        
        questButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        questButton.layer.shadowOpacity = 1
        questButton.layer.shadowRadius = 20
        questButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: questButton.frame.width, height: questButton.frame.height)).cgPath
        
        settingView.isHidden = true
        settingView.layer.opacity = 1.0
        questView.isHidden = true
        questView.layer.opacity = 1.0
    }
    
    
    // MARK: - IBAction
    @IBAction func goSetting(_ sender: UIButton) {
        settingView.isHidden = false
    }
    
    @IBAction func goQuest(_ sender: UIButton) {
        questView.isHidden = false
    }
    
    @IBAction func goGarage(_ sender: CustomGameButton) {
        let garage = UIStoryboard.init(name: "Garage", bundle: nil)
        guard let GarageViewController = garage.instantiateViewController(withIdentifier: "GarageViewController") as? GarageViewController else { return }
        GarageViewController.modalPresentationStyle = .fullScreen
        self.present(GarageViewController, animated: false, completion: nil)
        
    }
    
    @IBAction func goChapter(_ sender: CustomGameButton) {
        let chapter = UIStoryboard.init(name: "Chapter", bundle: nil)
        guard let ChapterViewController = chapter.instantiateViewController(withIdentifier: "ChapterViewController") as? ChapterViewController else {return}
        ChapterViewController.modalPresentationStyle = .fullScreen
        self.present(ChapterViewController, animated: false, completion: nil)
    }
}
