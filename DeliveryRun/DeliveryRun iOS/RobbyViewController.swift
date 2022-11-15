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
    
    
    @IBOutlet weak var hiddenView: UIView!
    @IBOutlet weak var questButton: CustomGameButton!
    @IBOutlet weak var garageButton: CustomGameButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var settingButton: UIButton!
    
    func addSetingView() {
            if let customView = Bundle.main.loadNibNamed("SettingView", owner: nil, options: nil)?.first as? UIView {
                customView.frame.size.width = 300
                customView.frame.size.height = 300
                hiddenView.addSubview(customView)
            }
        }
    func addQuestView() {
            if let customView = Bundle.main.loadNibNamed("QuestView", owner: nil, options: nil)?.first as? UIView {
                customView.frame.size.width = 300
                customView.frame.size.height = 300
                hiddenView.addSubview(customView)
            }
        }
    
    
    var sound:Sound = Sound(audioPlayer: AVAudioPlayer())
    override func viewDidLoad() {
        super.viewDidLoad()
        questButton.setTitle("퀘스트", for: .normal)
        questButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        garageButton.setTitle("차고", for: .normal)
        garageButton.setImage(UIImage(systemName: "car.fill"), for: .normal)
        startButton.setTitle("배달 준비", for: .normal)
        addQuestView()
        addSetingView()
    }
    
    @IBAction func questPopUp(_ sender: CustomGameButton) {
        if hiddenView.isHidden {
            hiddenView.isHidden = false
        } else {
            hiddenView.isHidden = true
        }
    }
}

class CustomGameButton: UIButton {
    
    required init (coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
    
}

