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
    @IBOutlet weak var questProgress: UIProgressView!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var rewardButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
