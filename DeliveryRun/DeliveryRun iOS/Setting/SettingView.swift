//
//  QuestView.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/15.
//

import UIKit
import Foundation
import AVFAudio

class SettingView: UIView {
    let nibName = "SettingView"
    
    let userDefault = UserDefaultData.shared
    
    var sound = Sound(audioPlayer: AVAudioPlayer())

    @IBOutlet weak var BackgroundMusic: UISwitch!
    @IBOutlet weak var InGameSound: UISwitch!
    @IBOutlet weak var byLabel: UILabel!
    
    // StoryBoard Load
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 기본 View 설정
        guard let view = loadViewFromNib() else { return }
        self.addSubview(view)
        view.frame = self.bounds
        view.backgroundColor = .deliveryrunPurple
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        view.layer.cornerRadius = 10
        
        byLabel.text = "Developed by Team Compiler\nver 1.0.0"
        byLabel.font = UIFont(name:"BMJUAOTF", size: 15)
        byLabel.textColor = .white
        byLabel.textAlignment = .center
        byLabel.numberOfLines = 2
        
        // UserDefault Get
        BackgroundMusic.isOn = false
        InGameSound.isOn = false
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func settingCheckButtonPressed(_ sender: CustomGameButton) {
        self.isHidden.toggle()
    }
    
    @IBAction func backgroundOnOff(_ sender: UISwitch) {
        if BackgroundMusic.isOn {
            sound.playSound(soundName: "robby")
        } else {
            sound.stopSound()
        }
    }
}