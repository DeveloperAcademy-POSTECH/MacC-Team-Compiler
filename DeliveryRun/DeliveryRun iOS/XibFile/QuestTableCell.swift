//
//  QuestTableCell.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/21.
//

import UIKit

class QuestTableCell: UITableViewCell {
    

    @IBOutlet weak var questTitleLabel: UILabel!
    @IBOutlet weak var questSubTitleLabel: UILabel!
    @IBOutlet weak var questProgress: CustomUiProgressView!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var rewardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rewardButton.setTitle("보상 받기", for: .normal)
        questProgress.progress = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func rewardButtonPressed(_ sender: CustomQuestButton) {
        print(questSubTitleLabel.text)
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
        self.font = UIFont(name: "BMJUAOTF", size: 30)
        self.textColor = .white
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
