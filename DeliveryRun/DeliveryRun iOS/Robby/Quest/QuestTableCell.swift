//
//  QuestTableCell.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/21.
//

import UIKit

class QuestTableCell: UITableViewCell {
    
    let userDefault = UserDefaultData.shared
    let gameEffectSound = GameSound.shared
    
    var questDone:Bool = false
    
    
    
    @IBOutlet weak var questTitleLabel: UILabel!
    @IBOutlet weak var questSubTitleLabel: UILabel!
    @IBOutlet weak var questProgressLabel: UILabel!
    @IBOutlet weak var questProgressBar: CustomUIProgressView!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var questCheckButton: CustomGameButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questTitleLabel.font = UIFont(name: "BMJUAOTF", size: 20)
        questTitleLabel.textAlignment = .left
        questTitleLabel.textColor = .white
        
        questSubTitleLabel.font = UIFont(name: "BMJUAOTF", size: 15)
        questSubTitleLabel.textAlignment = .left
        questSubTitleLabel.textColor = .white
        
        questProgressLabel.font = UIFont(name: "BMJUAOTF", size: 10)
        questProgressLabel.textAlignment = .center
        questProgressLabel.textColor = .white
        
        questImage.layer.cornerRadius = 10
        questImage.layer.borderWidth = 1
        questImage.layer.borderColor = UIColor.white.cgColor
        questImage.layer.masksToBounds = true
        
        questCheckButton.backgroundColor = .deliveryrunRed
        questCheckButton.titleLabel!.font = UIFont(name: "BMJUAOTF", size: 25)
        questCheckButton.setTitle("보상 받기", for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func RewardPressed(_ sender: CustomGameButton) {
        if userDefault.soundEffect {
            gameEffectSound.playSound(soundName: "RewardSound")
        }
        questCheckButton.layer.opacity = 0.5
        if questTitleLabel.text == "점프킹" {
            userDefault.jumpQuestCompleted()
        } else if questTitleLabel.text == "하남자특" {
            userDefault.breakQuestCompleted()
        } else {
            userDefault.collisionQuestCompleted()
        }
    }
}
