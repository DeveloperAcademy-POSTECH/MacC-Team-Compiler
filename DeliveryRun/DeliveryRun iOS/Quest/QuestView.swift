//
//  QuestView.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/11/25.
//

import UIKit
import Foundation

class QuestView: UIView {

    let nibName = "QuestView"
    
    let userDefault = UserDefaultData.shared
    let gameSound = GameSound.shared
    
    var quests:[Quest] = []
    
    
    @IBOutlet weak var checkButton: CustomGameButton!
    @IBOutlet weak var questTableView: UITableView!
    
    @IBAction func pressCheckButton(_ sender: Any) {
        self.isHidden.toggle()
        gameSound.playGameSound(soundName: "ButtonSound")
        
    }
    
    // StoryBoard Load
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let quests:[Quest] = [
            userDefault.defaults.setUserDefaultToObject(dataType: Quest.self, key: "JumpQuest")!,
            userDefault.defaults.setUserDefaultToObject(dataType: Quest.self, key: "BreakQuest")!,
            userDefault.defaults.setUserDefaultToObject(dataType: Quest.self, key: "CollisionQuest")!
        ]
        self.quests = quests

        
        // 기본 View 설정
        guard let view = loadViewFromNib() else { return }
        self.addSubview(view)
        view.frame = self.bounds
        view.backgroundColor = .deliveryrunPurple
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        
        questTableView.dataSource = self
        questTableView.delegate = self
        questTableView.backgroundColor = .clear
        questTableView.showsVerticalScrollIndicator = false
        questTableView.showsHorizontalScrollIndicator = false
        questTableView.register(UINib(nibName: "QuestTableCell", bundle: nil), forCellReuseIdentifier: "QuestTableCell")
        
        
        checkButton.setTitle("확인", for: .normal)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

extension QuestView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questTableView.dequeueReusableCell(withIdentifier: "QuestTableCell", for: indexPath) as! QuestTableCell
        if indexPath.row == 0 {
            print("JumpQuestDone", userDefault.jumpQuestDone)
            cell.questTitleLabel.text = quests[0].title
            cell.questSubTitleLabel.text = quests[0].subTitle
            cell.questImage.image = UIImage(named: quests[0].imageURL)
            cell.questProgressBar.progress = Float(userDefault.jumpData) / Float(quests[indexPath.row].totalNumber)
            cell.questProgressLabel.text = String(format: "%D / %D", userDefault.jumpData, quests[0].totalNumber)
            if quests[0].totalNumber <= userDefault.jumpData {
                cell.questCheckButton.isHidden = false
            } else {
                cell.questCheckButton.isHidden = true
            }
            if userDefault.jumpQuestDone {
                cell.questCheckButton.layer.opacity = 0.5
            }
        } else if indexPath.row == 1 {
            print("BreakQuestDone", userDefault.breakQuestDone)
            cell.questTitleLabel.text = quests[1].title
            cell.questSubTitleLabel.text = quests[1].subTitle
            cell.questImage.image = UIImage(named: quests[1].imageURL)
            cell.questProgressBar.progress = Float(userDefault.breakData) / Float(quests[indexPath.row].totalNumber)
            cell.questProgressLabel.text = String(format: "%D / %D", userDefault.breakData, quests[1].totalNumber)
            if quests[1].totalNumber <= userDefault.breakData {
                cell.questCheckButton.isHidden = false
            } else {
                cell.questCheckButton.isHidden = true
            }
            if userDefault.breakQuestDone {
                cell.questCheckButton.layer.opacity = 0.5
            }
        } else {
            cell.questTitleLabel.text = quests[2].title
            cell.questSubTitleLabel.text = quests[2].subTitle
            cell.questImage.image = UIImage(named: quests[2].imageURL)
            cell.questProgressBar.progress = Float(userDefault.collisionData) / Float(quests[2].totalNumber)
            cell.questProgressLabel.text = String(format: "%D / %D", userDefault.collisionData, quests[2].totalNumber)
            if quests[2].totalNumber <= userDefault.collisionData {
                cell.questCheckButton.isHidden = false
            } else {
                cell.questCheckButton.isHidden = true
            }
            if userDefault.collisionQuestDone {
                cell.questCheckButton.layer.opacity = 0.5
            }
        }
        
        // Cell Layout
        cell.backgroundColor = UIColor.deliveryrunBlack?.withAlphaComponent(0.6)
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 5, dy: 5)
        cell.layer.mask = maskLayer
    }
}

