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
    
    var sound:Sound = Sound(audioPlayer: AVAudioPlayer())
    @IBOutlet weak var robbyButton: gameButton!
    
    
    @IBOutlet weak var SettingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        robbyButton.setTitle("게임시작", for: .normal)
    }
    
    @IBAction func backgroundOnOff(_ sender: UISwitch) {
        if sender.isOn {
            sound.playSound(soundName: "robby")
        } else {
            sound.stopSound()
        }
    }
    
    @IBAction func soundOnOff(_ sender: UISwitch) {
        
    }
    
    
}

class gameButton: UIButton {
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}

