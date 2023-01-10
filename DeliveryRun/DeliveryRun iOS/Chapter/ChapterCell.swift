//
//  ChapterCell.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/24.
//

import UIKit

class ChapterCell: UICollectionViewCell {
    static let id = "chaptercell"
    
    // Cell 배경 View
    let backView: UIImageView = {
        let view = UIImageView()
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
    
    // Chapter Index Label
    let chapterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"BMJUAOTF", size:20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let lockView: UIView = {
       let view = UIView()
        view.backgroundColor = .deliveryrunBlack!.withAlphaComponent(0.6)
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let lockImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "lock.fill")!.resized(to:CGSize(width:40, height:40)).withTintColor(.deliveryrunRed!)
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView.addSubview(self.backView)
        self.contentView.addSubview(self.chapterLabel)
        
        NSLayoutConstraint.activate([
              self.backView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
              self.backView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
              self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
              self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
              
              self.chapterLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
              self.chapterLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
