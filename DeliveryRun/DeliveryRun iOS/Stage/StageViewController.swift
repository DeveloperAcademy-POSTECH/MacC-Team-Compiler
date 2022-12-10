//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var stageCollectionView: UICollectionView!
    @IBOutlet weak var stageDetailView: UIView!
    @IBOutlet weak var settingView: SettingView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var startButton: CustomGameButton!
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    
    @IBAction func pressSettingButton(_ sender: Any) {
        settingView.isHidden = false
    }
    
    var stages:[Stage] = []
    var stageNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefault.setStageNumber(stageNumber:1)
        
        let stages: [Stage] = [
            UserDefaults.standard.setUserDefaultToObject(dataType: Stage.self, key: "StageOne")!,
            UserDefaults.standard.setUserDefaultToObject(dataType: Stage.self, key: "StageTwo")!,
            UserDefaults.standard.setUserDefaultToObject(dataType: Stage.self, key: "StageThree")!,
            UserDefaults.standard.setUserDefaultToObject(dataType: Stage.self, key: "StageFour")!,
            UserDefaults.standard.setUserDefaultToObject(dataType: Stage.self, key: "StageFive")!,
            Stage(name: "스테이지 6", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 7", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 8", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 9", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 10", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 11", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 12", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 13", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 14", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true),
            Stage(name: "스테이지 15", image: "stage5", targetRecord: 90.0, myRecord: 0.0, isLock: true)
        ]
        
        self.stages = stages

        
        let image = UIImage(named: "RobbyBack")
        backgroundImage.image = image?.applyBlur_usingClamp(radius: 50)
        
        stageCollectionView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        stageCollectionView.layer.cornerRadius = 10
        stageCollectionView.delegate = self
        stageCollectionView.dataSource = self
        stageCollectionView.allowsMultipleSelection = false
        stageCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .init())
        
        setStageDetail()
        
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
        case 1:
            starImage.image = UIImage(named: "Result Star 1")
            break
        case 2:
            starImage.image = UIImage(named: "Result Star 2")
            break
        case 3:
            starImage.image = UIImage(named: "Result Star 3")
            break
        default:
            starImage.image = UIImage(named: "Result Star 0")
            break
        }
    }
    
    @IBAction func goRobby(_ sender: UIButton) {
        let robby = UIStoryboard.init(name: "Robby", bundle: nil)
        guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "RobbyViewController")as? RobbyViewController else {return}
        RobbyViewController.modalPresentationStyle = .fullScreen
        self.present(RobbyViewController, animated: false, completion: nil)
    }
    
    @IBAction func goDelivery(_ sender: CustomGameButton) {
        let game = UIStoryboard.init(name: "Game", bundle: nil)
        guard let GameViewController = game.instantiateViewController(withIdentifier: "GameViewController")as? GameViewController else {return}
        GameViewController.modalPresentationStyle = .fullScreen
        GameViewController.stageNumber = stageNumber
        self.present(GameViewController, animated: false, completion: nil)
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
        
        stageNumber = Int(indexPath.row + 1)
        userDefault.setStageNumber(stageNumber: Int(indexPath.row + 1))
        
        // 별 개수에 따라 색 변경
        switch stages[indexPath.row].star {
        case 1:
            starImage.image = UIImage(named: "Result Star 1")
            break
        case 2:
            starImage.image = UIImage(named: "Result Star 2")
            break
        case 3:
            starImage.image = UIImage(named: "Result Star 3")
            break
        default:
            starImage.image = UIImage(named: "Result Star 0")
            break
        }
    }
}

