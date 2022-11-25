//
//  QuestView.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/25.
//

import UIKit
import Foundation

class QuestView: UIView {

    let nibName = "QuestView"
    
    // StoryBoard Load
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // 기본 View 설정
        guard let view = loadViewFromNib() else { return }
        self.addSubview(view)
        view.frame = self.bounds
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
