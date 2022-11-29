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
    
    let userDefaultData = UserDefaultData()
    
    @IBOutlet weak var questCheckButton: CustomGameButton!
    @IBOutlet weak var questTableView: UITableView!
    
    @IBAction func pressCheckButton(_ sender: Any) {
        self.isHidden.toggle()
    }
    
    // StoryBoard Load
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
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
        
        questCheckButton.setTitle("확인", for: .normal)
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
        cell.questTitleLabel.text = quests[indexPath.row].title
        cell.questSubTitleLabel.text = quests[indexPath.row].subTitle
        cell.questImage.image = quests[indexPath.row].image
        cell.questProgressBar.progress = Float(quests[indexPath.row].nowNumber) / Float(quests[indexPath.row].totalNumber)
        cell.questProgressLabel.text = String(format: "%D / %D", quests[indexPath.row].nowNumber, quests[indexPath.row].totalNumber)
        
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
