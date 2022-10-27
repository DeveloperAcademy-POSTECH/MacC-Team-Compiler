//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    
    @IBOutlet weak var StageDetailView: UIView!
    @IBOutlet weak var stageStartBtn: gameButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        StageDetailView.layer.cornerRadius = 10
        StageDetailView.layer.masksToBounds = true
        stageStartBtn.setTitle("스테이지 시작", for: .normal)
        stageStartBtn.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 20)
    }
}

extension StageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCell", for: indexPath) as! StageCell
        cell.stageLevel.text = String(format: "Stage Levle: %D", indexPath.row)
        return cell
    }
}

extension StageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
