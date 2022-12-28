//
//  StageViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/10/16.
//

import UIKit

class StageViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared
    let gameEffectSound = GameSound.shared
    
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
    
    @IBOutlet weak var chapterNumberLabel: UILabel!
    @IBOutlet weak var chapterStepper: UIStepper!
    @IBAction func pressSettingButton(_ sender: Any) {
        settingView.isHidden = false
    }
    
    var chapterNumber:Int = 0
    var stageNumber:Int = 0
    
    var stages:[Stage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chapterNumber = userDefault.getChapterNumber()
        self.stageNumber = userDefault.getStageNumber()
        chapterStepper.value = Double(chapterNumber)
        chapterNumberLabel.text = String(format: "챕터번호:%D", chapterNumber)
        
        
        self.stages = [
            Stage(name: "스테이지 1", image: "stage1", targetRecord: userDefault.targetRecord[0][0], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 1)),
            Stage(name: "스테이지 2", image: "stage2", targetRecord: userDefault.targetRecord[0][1], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 2)),
            Stage(name: "스테이지 3", image: "stage3", targetRecord: userDefault.targetRecord[0][2], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 3)),
            Stage(name: "스테이지 4", image: "stage4", targetRecord: userDefault.targetRecord[0][3], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 4)),
            Stage(name: "스테이지 5", image: "stage5", targetRecord: userDefault.targetRecord[0][4], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 5)),
            Stage(name: "스테이지 6", image: "stage6", targetRecord: userDefault.targetRecord[0][5], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 6)),
            Stage(name: "스테이지 7", image: "stage7", targetRecord: userDefault.targetRecord[0][6], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 7)),
            Stage(name: "스테이지 8", image: "stage8", targetRecord: userDefault.targetRecord[0][7], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 8)),
            Stage(name: "스테이지 9", image: "stage9", targetRecord: userDefault.targetRecord[0][8], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 9)),
            Stage(name: "스테이지 10", image: "stage10", targetRecord: userDefault.targetRecord[0][9], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 10)),
            Stage(name: "스테이지 11", image: "stage11", targetRecord: userDefault.targetRecord[0][10], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 11)),
            Stage(name: "스테이지 12", image: "stage12", targetRecord: userDefault.targetRecord[0][11], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 12)),
            Stage(name: "스테이지 13", image: "stage13", targetRecord: userDefault.targetRecord[0][12], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 13)),
            Stage(name: "스테이지 14", image: "stage14", targetRecord: userDefault.targetRecord[0][13], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 14)),
            Stage(name: "스테이지 15", image: "stage15", targetRecord: userDefault.targetRecord[0][14], myRecord: userDefault.getRecordStage(chpaterNumber: 1, stageNumber: 1), unLock: userDefault.getClearStage(chapterNumber: 1, stageNumber: 15)),
        ]

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
    
    @IBAction func chpaterNumberStepper(_ sender: UIStepper) {
        chapterNumber = Int(chapterStepper.value)
        chapterNumberLabel.text = String(format: "챕터번호:%D", chapterNumber)
    }
    @IBAction func goRobby(_ sender: UIButton) {
        let robby = UIStoryboard.init(name: "Robby", bundle: nil)
        guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "RobbyViewController")as? RobbyViewController else {return}
        RobbyViewController.modalPresentationStyle = .fullScreen
        self.present(RobbyViewController, animated: false, completion: nil)
    }
    
    @IBAction func goDelivery(_ sender: CustomGameButton) {
        if userDefault.soundEffect {
            gameEffectSound.playSound(soundName: "GoDeliverySound")
        }
        userDefault.setChapterAndStage(chapterNumber: chapterNumber, stageNumber: stageNumber)
        print(chapterNumber,stageNumber)
        let game = UIStoryboard.init(name: "Game", bundle: nil)
        guard let GameViewController = game.instantiateViewController(withIdentifier: "GameViewController")as? GameViewController else {return}
        GameViewController.modalPresentationStyle = .fullScreen
        GameViewController.stageNumber = stageNumber
        GameViewController.chapterNumber = chapterNumber
        GameViewController.targetRecord = stages[stageNumber].targetRecord
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
        cell.unLock = stages[indexPath.row].unLock
        if !cell.unLock {
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
        userDefault.setChapterAndStage(chapterNumber: 1, stageNumber: Int(indexPath.row + 1))
        
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

