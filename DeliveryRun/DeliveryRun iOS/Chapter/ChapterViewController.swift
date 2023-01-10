//
//  ChapterViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/21.
//

import UIKit

class ChapterViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var chapterCollectionView: UICollectionView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    @IBAction func goRobby(_ sender: UIButton) {
        let robby = UIStoryboard.init(name: "Robby", bundle: nil)
        guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "RobbyViewController")as? RobbyViewController else {return}
        RobbyViewController.modalPresentationStyle = .fullScreen
        self.present(RobbyViewController, animated: false, completion: nil)
    }
    
    @IBAction func goSetting(_ sender: UIButton) {
        settingView.isHidden = false
    }
    
    
    // MARK: - viewDidLoad
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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        chapterCollectionView.collectionViewLayout = flowLayout
        
        settingView.layer.cornerRadius = 10
        settingView.alpha = 1.0
        settingView.isHidden = true
        
        backButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        backButton.layer.shadowOpacity = 1
        backButton.layer.shadowRadius = 20
        backButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: backButton.frame.width, height: backButton.frame.height)).cgPath
        
        settingButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        settingButton.layer.shadowOpacity = 1
        settingButton.layer.shadowRadius = 20
        settingButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: settingButton.frame.width, height: settingButton.frame.height)).cgPath
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
        cell.chapterLabel.text = String(format: "Chapter %d", indexPath.row + 1)
        cell.backView.image = UIImage(named: String(format: "chapter%D", indexPath.row + 1))
        
        if indexPath.row > 0 {
            cell.addSubview(cell.lockView)
            cell.addSubview(cell.lockImageView)
            cell.isUserInteractionEnabled = false
            
            NSLayoutConstraint.activate([
                cell.lockView.leftAnchor.constraint(equalTo: cell.leftAnchor),
                cell.lockView.rightAnchor.constraint(equalTo: cell.rightAnchor),
                cell.lockView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
                cell.lockView.topAnchor.constraint(equalTo: cell.topAnchor),
                
                cell.lockImageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                cell.lockImageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
            ])
        } else {
            cell.isUserInteractionEnabled = true
        }
        
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
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
    }
}

// Cell 선택 시 StageView로 연결
extension ChapterViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stage = UIStoryboard.init(name: "Stage", bundle: nil)
        guard let StageViewController = stage.instantiateViewController(withIdentifier: "StageViewController") as? StageViewController else {return}
        userDefault.setChapterNumber(chapterNumber: indexPath.row + 1)
        StageViewController.modalPresentationStyle = .fullScreen
        self.present(StageViewController, animated: false, completion: nil)
    }
}

