//
//  ChapterViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/21.
//

import UIKit

class ChapterViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "RobbyBack")
        backgroundImage.image = image?.applyBlur_usingClamp(radius: 50)
        
        chapterCollectionView.backgroundColor = .clear
        chapterCollectionView.delegate = self
        chapterCollectionView.dataSource = self
        chapterCollectionView.isScrollEnabled = true
        chapterCollectionView.showsVerticalScrollIndicator = false
        chapterCollectionView.showsHorizontalScrollIndicator = false
        chapterCollectionView.allowsMultipleSelection = false
    }

}

extension ChapterViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // Cell 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // Cell 초기화
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chaptercell", for: indexPath) as! ChapterCell
        
        return cell
    }
}

// Cell Size & Insets
extension ChapterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = CGFloat(Int((collectionView.frame.height - 40)))
        let size = CGSize(width: height, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

// Cell 선택 시 정보 변경
extension ChapterViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

