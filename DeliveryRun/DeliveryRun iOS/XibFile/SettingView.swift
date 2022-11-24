//
//  QuestView.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/15.
//

import UIKit
import Foundation

class SettingView: UIView {
    @IBOutlet weak var backgroundSlider: CustomUiSlider!
    @IBOutlet weak var soundSlider: CustomUiSlider!
    @IBOutlet weak var byLabel: UILabel!
    var backgroundValue:Float = 0.0
    var soundValue:Float = 0.0
    var settingViewIsHidden = false
    let nibName = "SettingView"
    var contentView: UIView?
    
    // StoryBoard로 불러오기!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        byLabel.text = "Developed by Team Compiler ver 1.0.0"
    }
    func returnFloat() -> Float {
        0.0
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
        self.thumbTintColor = .deliveryrunRed
        self.minimumTrackTintColor = .deliveryrunYellow
        self.maximumTrackTintColor = .white
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.trackRect(forBounds: bounds)
        rect.size.height = 7
        return rect
    } 
}

class CustomUILabel: UILabel {
    required init (coder aDecorder:NSCoder) {
        super.init(coder: aDecorder)!
        self.font = UIFont(name: "BMJUAOTF", size: 30)
        self.textColor = .white
    }
}
