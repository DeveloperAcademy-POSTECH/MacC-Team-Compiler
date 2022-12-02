//
//  PauseView.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/02.
//

import UIKit

class PauseView: UIView {
    let nibName = "PauseView"
    
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
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

}
