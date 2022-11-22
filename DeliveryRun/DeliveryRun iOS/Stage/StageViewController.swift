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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stageCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageCollectionView.layer.cornerRadius = 10
        
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stagecell", for: indexPath) as! StageCell
        cell.stageLabel.text = String(format: "%d", indexPath.row + 1)
        return cell
    }
}

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
