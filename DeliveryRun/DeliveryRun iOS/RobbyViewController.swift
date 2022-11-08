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
    
    
    @IBOutlet weak var SettingView: UIView!
    @IBOutlet weak var robbyButton: gameButton!
    
    
    @IBOutlet weak var SettingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        robbyButton.setTitle("게임시작", for: .normal)
        SettingView.isHidden = true
    }
    
    @IBAction func SettingViewButton(_ sender: UIButton) {
        SettingView.isHidden = false
    }
    @IBAction func SettingViewOff(_ sender: UIButton) {
        SettingView.isHidden = true
    }
    
    @IBAction func backgroundOnOff(_ sender: UISwitch) {
        
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

