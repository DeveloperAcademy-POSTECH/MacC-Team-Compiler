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
    
    @IBOutlet weak var questButton: CustomGameButton!
    @IBOutlet weak var garageButton: CustomGameButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var questTableView: UITableView!
    @IBOutlet weak var questCheckButton: CustomGameButton!
    @IBOutlet weak var questView: UIView!
    var sound:Sound = Sound(audioPlayer: AVAudioPlayer())
    override func viewDidLoad() {
        super.viewDidLoad()
        questButton.setTitle("퀘스트", for: .normal)
        questButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        garageButton.setTitle("차고", for: .normal)
        garageButton.setImage(UIImage(systemName: "car.fill"), for: .normal)
        startButton.setTitle("배달 준비", for: .normal)
        questCheckButton.setTitle("확인", for: .normal)
        settingView.isHidden = true
        settingView.layer.opacity = 1.0
        questTableView.isHidden = true
        questTableView.layer.opacity = 1.0
        
        questTableView.dataSource = self
//        // NibFile Swift File명 ReuseableIdentifier Cell Identifier
//        questView.register(QuestTableCell.self, forCellReuseIdentifier: "QuestTableCell")
        questTableView.register(UINib(nibName: "QuestTableCell", bundle: nil), forCellReuseIdentifier: "QuestTableCell")
    }
    
    

    @IBAction func settingPopUp(_ sender: CustomGameButton) {
        if settingView.isHidden {
            settingView.isHidden = false
        } else {
            settingView.isHidden = true
            questTableView.isHidden = false
        }
    }
    
    @IBAction func questPopUp(_ sender: CustomGameButton) {
        if questView.isHidden {
            questView.isHidden = false
        } else {
            questView.isHidden = true
            questTableView.isHidden = false
        }
    }
    @IBAction func questCheckPopUp(_ sender: UIButton) {
        if questView.isHidden {
            questView.isHidden = false
        } else {
            questView.isHidden = true
        }
    }
}

extension RobbyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questTableView.dequeueReusableCell(withIdentifier: "QuestTableCell", for: indexPath) as! QuestTableCell
        cell.questTitleLabel.text = "점프킹"
        return cell
    }
    
    
}

class CustomGameButton: UIButton {
    required init (coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}

