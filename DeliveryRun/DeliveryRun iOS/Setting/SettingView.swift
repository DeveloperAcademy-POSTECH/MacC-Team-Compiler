//
//  QuestView.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/15.
//

import UIKit
import Foundation

class SettingView: UIView {
    
    
    let nibName = "SettingView"
    
    let userDefaultData = UserDefaultData()
    
    @IBOutlet weak var BackMusicView: UIView!
    @IBOutlet weak var SoundMusicView: UIView!

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
        
        BackMusicView.backgroundColor = .deliveryrunBlack?.withAlphaComponent(0.6)
        BackMusicView.layer.cornerRadius = 10
        BackMusicView.layer.borderColor = UIColor.white.cgColor
        BackMusicView.layer.borderWidth = 1
        
        SoundMusicView.backgroundColor = .deliveryrunBlack?.withAlphaComponent(0.6)
        SoundMusicView.layer.cornerRadius = 10
        SoundMusicView.layer.borderColor = UIColor.white.cgColor
        SoundMusicView.layer.borderWidth = 1
        
        byLabel.text = "Developed by Team Compiler\nver 1.0.0"
        byLabel.font = UIFont(name:"BMJUAOTF", size: 15)
        byLabel.textColor = .white
        byLabel.textAlignment = .center
        byLabel.numberOfLines = 2
        
        BackgroundMusic.isOn = userDefaultData.backgroundMusic
        InGameSound.isOn = userDefaultData.inGameSound
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func settingCheckButtonPressed(_ sender: CustomGameButton) {
        self.isHidden.toggle()
        userDefaultData.setSetting(backgroundMusic: BackgroundMusic.isOn, inGameSound: InGameSound.isOn)
    }
}


class CustomUiSlider: UISlider {
    required init (coder aDecorder:NSCoder) {
        super.init(coder: aDecorder)!
        self.thumbTintColor = .deliveryrunYellow
        self.minimumTrackTintColor = .deliveryrunRed
        self.maximumTrackTintColor = .white
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 5
        return rect
    } 
}
