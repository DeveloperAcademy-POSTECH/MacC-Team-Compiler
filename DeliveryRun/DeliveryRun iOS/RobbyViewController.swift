//
//  GameViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/11.
//

import UIKit
import SpriteKit
import GameplayKit

class RobbyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doGameStart(_ sender: UIButton) {
        for fontFamily in UIFont.familyNames {
            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
                print(fontName)
            }
        }
    }
}

class gameButton: UIButton {
    required init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.setTitle("게임 시작", for: .normal)
        self.tintColor = .white
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}

