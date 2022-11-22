//
//  StageCell.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/27.
//

import UIKit

class StageCell: UICollectionViewCell {
    static let id = "stagecell"
    
    // Cell 배경 View
    let backView: UIView = {
        let view = UIView()
        view.backgroundColor = .deliveryrunBlack
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"BMJUAOTF", size:20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self.backView)
        self.contentView.addSubview(self.stageLabel)
        NSLayoutConstraint.activate([
              self.backView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
              self.backView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
              self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
              self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
              
              self.stageLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
              self.stageLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        ])
    }
}
