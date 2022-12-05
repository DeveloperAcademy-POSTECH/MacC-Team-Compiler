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
    

    @IBOutlet weak var BackgroundMusicView: UIView!
    @IBOutlet weak var EffectMusicView: UIView!
    
    @IBOutlet weak var BackgroundSwitch: UISwitch!
    
    @IBOutlet weak var GameSoundSwitch: UISwitch!
    @IBOutlet weak var byLabel: UILabel!
    
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
        
        BackgroundMusicView.backgroundColor = .deliveryrunBlack!.withAlphaComponent(0.6)
        BackgroundMusicView.layer.cornerRadius = 10
        BackgroundMusicView.layer.borderWidth = 1
        BackgroundMusicView.layer.borderColor = UIColor.white.cgColor
        
        EffectMusicView.backgroundColor = .deliveryrunBlack!.withAlphaComponent(0.6)
        EffectMusicView.layer.cornerRadius = 10
        EffectMusicView.layer.borderWidth = 1
        EffectMusicView.layer.borderColor = UIColor.white.cgColor
        
        byLabel.text = "Developed by Team Compiler\nver 1.0.0"
        byLabel.font = UIFont(name:"BMJUAOTF", size: 15)
        byLabel.textColor = .white
        byLabel.textAlignment = .center
        byLabel.numberOfLines = 2
        
        // UserDefault Get
        BackgroundSwitch.isOn = userDefault.backgroundMusic
        GameSoundSwitch.isOn = userDefault.gameSound
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    // Button IBActions
    @IBAction func settingCheckButtonPressed(_ sender: CustomGameButton) {
        self.isHidden.toggle()
        // UserDefault Set
        userDefault.setSetting(backgroundMusic: BackgroundSwitch.isOn, gameSound: GameSoundSwitch.isOn)
    }
    
    // TODO: BackgroudMusci ON OFF
    @IBAction func backgroundOnOff(_ sender: UISwitch) {
        print("Play Background")
    }
}
