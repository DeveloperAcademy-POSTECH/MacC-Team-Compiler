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
    
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var questView: QuestView!
    @IBOutlet weak var questButton: CustomGameButton!
    @IBOutlet weak var garageButton: CustomGameButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var settingButton: UIButton!
    
    var sound:Sound = Sound(audioPlayer: AVAudioPlayer())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questButton.setTitle(" 퀘스트", for: .normal)
        questButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        
        garageButton.setTitle(" 차고", for: .normal)
        garageButton.setImage(UIImage(systemName: "car.fill"), for: .normal)
        
        startButton.setTitle("배달 준비", for: .normal)
        
        settingButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        settingButton.layer.shadowOpacity = 1
        settingButton.layer.shadowRadius = 20
        settingButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: settingButton.frame.width, height: settingButton.frame.height)).cgPath
        
        settingView.isHidden = true
        questView.isHidden = true
        settingView.layer.opacity = 1.0
        questView.layer.opacity = 1.0
    }
    
    @IBAction func SettingPressed(_ sender: UIButton) {
        settingView.isHidden = false
    }
    @IBAction func QeustPressed(_ sender: CustomGameButton) {
        questView.isHidden = false
    }
    
    @IBAction func goDelivery(_ sender: CustomGameButton) {
        let stage = UIStoryboard.init(name: "Stage", bundle: nil)
                guard let StageViewController = stage.instantiateViewController(withIdentifier: "StageViewController")as? StageViewController else {return}
        StageViewController.modalPresentationStyle = .fullScreen
                self.present(StageViewController, animated: false, completion: nil)
    }
}

