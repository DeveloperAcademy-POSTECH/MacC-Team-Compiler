//
//  StageCell.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/27.
//

import UIKit

class StageCell: UICollectionViewCell {
    static let id = "stagecell"
    
    var isLock: Bool = false
    
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
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // Stage Index Label
    let stageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"BMJUAOTF", size:20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let unLockView: UIView = {
       let view = UIView()
        view.backgroundColor = .deliveryrunBlack!.withAlphaComponent(0.6)
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let unLockImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lock.fill")!.resized(to:CGSize(width:40, height:40)).withTintColor(.deliveryrunRed!)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.layer.cornerRadius = 20.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    // isSelected
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backView.layer.borderColor = UIColor.deliveryrunYellow!.cgColor
                self.backView.layer.borderWidth = 5
            } else {
                self.backView.layer.borderColor = UIColor.white.cgColor
                self.backView.layer.borderWidth = 2
            }
        }
    }
}
