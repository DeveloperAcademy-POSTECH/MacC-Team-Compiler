//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared
    
    
    @IBOutlet weak var stageCollectionView: UICollectionView!
    @IBOutlet weak var stageDetailView: UIView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var starImage: UIImageView!
    
    @IBOutlet weak var starImageOne: UIImageView!
    @IBOutlet weak var starImageTwo: UIImageView!
    @IBOutlet weak var starImageThree: UIImageView!
    
    @IBAction func pressSettingButton(_ sender: Any) {
        settingView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stageCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageCollectionView.layer.cornerRadius = 10
        stageCollectionView.delegate = self
        stageCollectionView.dataSource = self
        stageCollectionView.allowsMultipleSelection = false
        stageCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .init())
        
        setStageDetail()
        
        settingView.layer.cornerRadius = 10
        settingView.isHidden = true
    }
    
    // Stage Detail View 설정
    func setStageDetail() {
        stageDetailView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageDetailView.layer.cornerRadius = 10
        
        startButton.setTitle("배달 출발", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "BMJUAOTF", size: 30)
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        
        stageNameLabel.text = stages[0].name
        stageNameLabel.textColor = .white
        stageNameLabel.font = UIFont(name:"BMJUAOTF", size: 35)
        
        recordLabel.text = "목표기록 : \(stages[0].targetRecord)\n현재기록 : \(stages[0].myRecord)"
        recordLabel.textAlignment = .center
        recordLabel.numberOfLines = 2
        recordLabel.textColor = .white
        recordLabel.font = UIFont(name:"BMJUAOTF", size: 20)
        
        // 별 개수에 따라 색 변경
        switch stages[0].star {
        case "resultStar1":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .systemGray
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar1")
            break
        case "resultStar2":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .deliveryrunYellow
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar2")
            break
        case "resultStar3":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .deliveryrunYellow
            starImageThree.tintColor = .deliveryrunYellow
            starImage.image = UIImage(named: "resultStar3")
            break
        default:
            starImageOne.tintColor = .systemGray
            starImageTwo.tintColor = .systemGray
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar1")
            break
        }
    }
    
    
    @IBAction func goRobby(_ sender: UIButton) {
        let robby = UIStoryboard.init(name: "Robby", bundle: nil)
                guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "Robby")as? RobbyViewController else {return}
                
        RobbyViewController.modalPresentationStyle = .fullScreen
                self.present(RobbyViewController, animated: true, completion: nil)
    }
    @IBAction func goDelivery(_ sender: CustomGameButton) {
        let game = UIStoryboard.init(name: "Game", bundle: nil)
                guard let GameViewController = game.instantiateViewController(withIdentifier: "GameViewController")as? GameViewController else {return}

        GameViewController.modalPresentationStyle = .fullScreen
                self.present(GameViewController, animated: true, completion: nil)

    }
}


extension StageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // Cell 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stages.count
    }
    
    // Cell 초기화
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stagecell", for: indexPath) as! StageCell
        
        // Cell이 Lock인 경우
        cell.isLock = stages[indexPath.row].isLock
        if cell.isLock {
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
        }
        
        // Cell 텍스트 및 이미지 구성
        cell.stageLabel.text = String(format: "%d", indexPath.row + 1)
        cell.foodImageView.image = UIImage(named:stages[indexPath.row].image)?.resized(to:CGSize(width:40, height:40))
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
        // Label 수정
        stageNameLabel.text = stages[indexPath.row].name
        recordLabel.text = "목표기록 : \(stages[indexPath.row].targetRecord)\n현재기록 : \(stages[indexPath.row].myRecord)"
        
        // 별 개수에 따라 색 변경
        switch stages[indexPath.row].star {
        case "resultStar1":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .systemGray
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar1")
            break
        case "resultStar2":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .deliveryrunYellow
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar2")
            break
        case "resultStar3":
            starImageOne.tintColor = .deliveryrunYellow
            starImageTwo.tintColor = .deliveryrunYellow
            starImageThree.tintColor = .deliveryrunYellow
            starImage.image = UIImage(named: "resultStar3")
            break
        default:
            starImageOne.tintColor = .systemGray
            starImageTwo.tintColor = .systemGray
            starImageThree.tintColor = .systemGray
            starImage.image = UIImage(named: "resultStar1")
            break
        }
    }
}


let stages: [Stage] = [
    UserDefaultData.staticDefaults.setUserDefaultToObject(dataType: Stage.self, key: "Stage1")!,
    UserDefaultData.staticDefaults.setUserDefaultToObject(dataType: Stage.self, key: "Stage2")!,
    UserDefaultData.staticDefaults.setUserDefaultToObject(dataType: Stage.self, key: "Stage3")!,
    UserDefaultData.staticDefaults.setUserDefaultToObject(dataType: Stage.self, key: "Stage4")!,
    UserDefaultData.staticDefaults.setUserDefaultToObject(dataType: Stage.self, key: "Stage5")!,
    Stage(name: "스테이지 6", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 7", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 8", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 9", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 10", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 11", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 12", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 13", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 14", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true),
    Stage(name: "스테이지 15", image: "", targetRecord: 90.0, myRecord: 0.0, isLock: true)
]
