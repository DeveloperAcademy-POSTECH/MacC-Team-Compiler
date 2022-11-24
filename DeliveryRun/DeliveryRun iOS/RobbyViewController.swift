//
//  GameViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/11.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class RobbyViewController: UIViewController {
    
    let quests: [Quest] = [
        Quest(title: "점프킹", subTitle: "총 점프 횟수 50회를 달성하세요.", image:UIImage(named: "collection1")!, reward: "Bike", totalNumber: 50, nowNumber: 10, isClear: false),
        Quest(title: "하남자특", subTitle: "브레이크를 사용해서 최저 속도를 20회 달성하세요.", image:UIImage(named: "collection2")!, reward: "Scooter", totalNumber: 20, nowNumber: 20, isClear: true),
        Quest(title: "상남자특", subTitle: "장애물과 50회 충돌하세요.", image:UIImage(named: "collection3")!, reward: "Car", totalNumber: 50, nowNumber: 10, isClear: false),
    ]
    
    
    
    @IBOutlet weak var coatingView: UIView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var questView: UIView!
    @IBOutlet weak var questButton: CustomGameButton!
    @IBOutlet weak var garageButton: CustomGameButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var questCheckButton: CustomGameButton!
    @IBOutlet weak var questTableView: UITableView!
    var toggleBool:Bool = false
    var sound:Sound = Sound(audioPlayer: AVAudioPlayer())
    override func viewDidLoad() {
        super.viewDidLoad()
        questButton.setTitle("퀘스트", for: .normal)
        questButton.setImage(UIImage(systemName: "list.bullet.circle.fill"), for: .normal)
        garageButton.setTitle("차고", for: .normal)
        garageButton.setImage(UIImage(systemName: "car.fill"), for: .normal)
        startButton.setTitle("배달 준비", for: .normal)
        questCheckButton.setTitle("확인", for: .normal)
        coatingView.isHidden = true
        settingView.isHidden = true
        questView.isHidden = true
        settingView.layer.opacity = 1.0
        questView.layer.opacity = 1.0
        questTableView.backgroundColor = UIColor(ciColor: .white)
        questTableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        questTableView.dataSource = self
        questTableView.delegate = self
        questTableView.register(UINib(nibName: "QuestTableCell", bundle: nil), forCellReuseIdentifier: "QuestTableCell")
    }
    
    @IBAction func QuestCheckPressed(_ sender: UIButton) {
        questView.isHidden = true
    }
    
    @IBAction func SettingPressed(_ sender: UIButton) {
        settingView.isHidden = false
    }
    @IBAction func QeustPressed(_ sender: CustomGameButton) {
        questView.isHidden = false
    }
}

extension RobbyViewController: UITableViewDataSource, UITableViewDelegate {
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
        // CellLayOut
        cell.backgroundColor = UIColor.deliveryrunOpacityBlack
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 10

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: verticalPadding/2, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }

    
    
    
    

    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
}


class CustomGameButton: UIButton {
    required init (coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)!
        self.backgroundColor = .deliveryrunBlack
        self.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        self.tintColor = .white
        self.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
    }
}

