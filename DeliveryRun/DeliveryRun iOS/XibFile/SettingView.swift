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
    
    @IBOutlet weak var BackMusicView: UIView!
    @IBOutlet weak var SoundMusicView: UIView!
    @IBOutlet weak var backgroundSlider: CustomUiSlider!
    @IBOutlet weak var soundSlider: CustomUiSlider!
    @IBOutlet weak var byLabel: UILabel!
    
    var backgroundValue:Float = 0.0
    var soundValue:Float = 0.0
    var settingViewIsHidden: Bool = false
    
    // StoryBoard Load
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 기본 View 설정
        guard let view = loadViewFromNib() else { return }
        self.addSubview(view)
        view.frame = self.bounds
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        BackMusicView.backgroundColor = .deliveryrunBlack
        BackMusicView.layer.cornerRadius = 10
        
        SoundMusicView.backgroundColor = .deliveryrunBlack
        SoundMusicView.layer.cornerRadius = 10
        
        byLabel.text = "Developed by Team Compiler\nver 1.0.0"
        byLabel.font = UIFont(name:"BMJUAOTF", size: 15)
        byLabel.textAlignment = .center
        byLabel.numberOfLines = 2
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func setBackgroundValue(_ sender: CustomUiSlider) {
        backgroundValue = backgroundSlider.value
    }
    
    @IBAction func setSoundValue(_ sender: CustomUiSlider) {
        soundValue = soundSlider.value
    }
    
    @IBAction func settingCheckButtonPressed(_ sender: CustomGameButton) {
        settingViewIsHidden.toggle()
        self.isHidden.toggle()
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
