//
//  StoryView.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/02.
//

import Foundation
import UIKit
class StoryView: UIView {
    
    
    let nibName = "StoryView"
    
    let userDefault = UserDefaultData.shared
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @IBOutlet weak var storyTextLabel: UILabel!
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
        
        
    }
    
}


