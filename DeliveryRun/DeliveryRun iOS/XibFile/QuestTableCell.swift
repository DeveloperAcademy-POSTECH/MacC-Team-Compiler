//
//  QuestTableCell.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/21.
//

import UIKit

class QuestTableCell: UITableViewCell {
    
    @IBOutlet weak var questTitleLabel: CustomQuestLabel!
    
    @IBOutlet weak var questSubTitleLabel: CustomQuestLabel!
    @IBOutlet weak var questProgressBar: CustomUiProgressView!
    @IBOutlet weak var questProgressLabel: CustomQuestLabel!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var questCheckButton: CustomQuestButton!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        questSubTitleLabel.font = UIFont(name: "BMJUAOTF", size: 12)
        questCheckButton.setTitle("보상 받기", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func RewardPressed(_ sender: CustomQuestButton) {
        print(questTitleLabel.text)
    }
}


class CustomUiProgressView: UIProgressView {
    
    required init (coder aDecorder:NSCoder) {
        super.init(coder: aDecorder)!
        self.progressTintColor = .deliveryrunYellow
    }
    
}

class CustomQuestLabel: UILabel {
    required init (coder aDecorder:NSCoder) {
        super.init(coder: aDecorder)!
        self.font = UIFont(name: "BMJUAOTF", size: 16)
        self.textColor = .white
        self.textAlignment = .center
    }
}



class CustomQuestButton: UIButton {
    required init (coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunRed
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}
