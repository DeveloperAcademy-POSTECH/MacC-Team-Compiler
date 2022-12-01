//
//  Custom.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/02.
//

import UIKit
import Foundation

// Custom Game Button
class CustomGameButton: UIButton {
    required init (coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
    }
}

// Custom UIProgressView
class CustomUIProgressView: UIProgressView {
    required init (coder aDecorder:NSCoder) {
        super.init(coder: aDecorder)!
        self.progressTintColor = .deliveryrunYellow
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
}
