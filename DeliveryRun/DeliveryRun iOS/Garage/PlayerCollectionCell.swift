//
//  PlayerCollectionCell.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/05.
//

import UIKit

class PlayerCollectionCell: UICollectionViewCell {
    
    var collectionName:String = ""

    @IBOutlet weak var AllView: UIView!
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var statView: UIView!
    
    @IBOutlet weak var checkButton: CustomGameButton!
    
    @IBOutlet weak var SpeedLabel: CustomUILabel!
    
    @IBOutlet weak var JumpLabel: CustomUILabel!
    
    @IBOutlet weak var SpeedProgress: UIProgressView!
    
    
    @IBOutlet weak var JumpProgress: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkButton.setTitle("선택", for: .normal)
        AllView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    }

    @IBAction func ChoiceButtonPressed(_ sender: CustomGameButton) {
        print(collectionName)
    }
}
