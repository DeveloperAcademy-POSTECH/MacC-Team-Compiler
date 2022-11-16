//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    @IBOutlet weak var StageDetailView: UIView!
    @IBOutlet weak var stageStartBtn: CustomGameButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StageDetailView.layer.cornerRadius = 10
        StageDetailView.layer.masksToBounds = true
        stageStartBtn.setTitle("배달 출발", for: .normal)
        stageStartBtn.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 20)
    }
}

extension StageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stagecell", for: indexPath) as! StageCell
        cell.stageLabel.text = String(format: "Stage %d", indexPath.row)
        return cell
    }
}

extension StageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = 70
            let size = CGSize(width: width, height: width)
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
