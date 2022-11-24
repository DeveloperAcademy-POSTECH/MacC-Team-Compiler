//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    @IBOutlet weak var stageCollectionView: UICollectionView!
    @IBOutlet weak var stageDetailView: UIView!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var starImageOne: UIImageView!
    @IBOutlet weak var starImageTwo: UIImageView!
    @IBOutlet weak var starImageThree: UIImageView!
    
    let stageList: [Stage] = [
        Stage(stageName: "스테이지 1", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 2, isLock: false),
        Stage(stageName: "스테이지 2", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 3", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 4", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 5", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 6", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 7", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 8", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 9", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 10", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 11", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 12", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 13", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 14", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false),
        Stage(stageName: "스테이지 15", foodImageName: "", targetRecord: 90.0, myRecord: 0.0, star: 0, isLock: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stageCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageCollectionView.layer.cornerRadius = 10
        stageCollectionView.delegate = self
        stageCollectionView.dataSource = self
        
        setStageDetail()
    }
    
    // Stage Detail View 설정
    func setStageDetail() {
        stageDetailView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageDetailView.layer.cornerRadius = 10
        
        startButton.setTitle("배달 출발", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        
        stageNameLabel.text = "스테이지 이름"
        stageNameLabel.textColor = .white
        stageNameLabel.font = UIFont(name:"BMJUAOTF", size: 35)
        
        recordLabel.text = "목표기록 : 00:00:00\n현재기록 : 00:00:00"
        recordLabel.textAlignment = .center
        recordLabel.numberOfLines = 2
        recordLabel.textColor = .white
        recordLabel.font = UIFont(name:"BMJUAOTF", size: 20)
    }
}


extension StageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // Cell 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    // Cell 초기화
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stagecell", for: indexPath) as! StageCell
        cell.stageLabel.text = String(format: "%d", indexPath.row + 1)
        return cell
    }
}

// Cell Size & Insets
extension StageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(Int((collectionView.frame.width - 120) / 5))
        let height = CGFloat(Int((collectionView.frame.height - 60) / 3))
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    }
}

// Cell 선택 시 정보 변경
extension StageViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stageNameLabel.text = stageList[indexPath.row].stageName
        recordLabel.text = "목표기록 : \(stageList[indexPath.row].targetRecord)\n현재기록 : \(stageList[indexPath.row].myRecord)"
    }
}
