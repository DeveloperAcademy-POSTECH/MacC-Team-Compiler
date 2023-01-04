//
//  PlayerCollectionCell.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/05.
//

import UIKit

protocol YourCellDelegate: AnyObject {
    func didCompleteOnboarding()
}

class PlayerCollectionCell: UICollectionViewCell {
    
    let userDefault = UserDefaultData.shared
    
    var collectionName:String = ""
    
    weak var delegate: YourCellDelegate?
    
    func dismissAction() {
        delegate?.didCompleteOnboarding()
    }
    

    @IBOutlet weak var AllView: UIView!
    @IBOutlet weak var collectionImage: UIImageView!
    
    @IBOutlet weak var statView: UIView!
    
    @IBOutlet weak var checkButton: CustomGameButton!
    
    @IBOutlet weak var SpeedLabel: CustomUILabel!
    
    @IBOutlet weak var JumpLabel: CustomUILabel!
    
    @IBOutlet weak var SpeedProgress: UIProgressView!
    
    
    @IBOutlet weak var JumpProgress: UIProgressView!
    
    @IBOutlet weak var SpecialLabel: CustomUILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkButton.setTitle("선택", for: .normal)
        AllView.backgroundColor = .clear
    }

    @IBAction func ChoiceButtonPressed(_ sender: CustomGameButton) {
        userDefault.setSkin(skinName: collectionName)
        dismissAction()
    }
}

