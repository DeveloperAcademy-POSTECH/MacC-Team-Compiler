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
    @IBOutlet weak var checkButton: CustomGameButton!
    let nibName = "SettingView"
    var contentView: UIView?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        byLabel.text = "Developed by Team Compilerver 1.0.0"
        checkButton.setTitle("확인", for: .normal)
        
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @IBAction func setBackgroundValue(_ sender: CustomUiSlider) {
    }
    
    @IBAction func setSoundValue(_ sender: CustomUiSlider) {
    }
    
    @IBAction func saveValueButton(_ sender: CustomGameButton) {
        print(backgroundSlider.value)
        print(soundSlider.value)
        self.isHidden = true
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


//class CustomGameButton: UIButton {
//
//    required init (coder aDecoder:NSCoder) {
//        super.init(coder: aDecoder)!
//        self.backgroundColor = .deliveryrunBlack
//        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
//        self.tintColor = .white
//        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 0.5
//        self.layer.cornerRadius = 10
//    }
//
//}
