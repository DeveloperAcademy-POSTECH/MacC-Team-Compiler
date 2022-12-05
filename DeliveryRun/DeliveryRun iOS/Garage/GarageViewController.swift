//
//  GarageViewController.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/04.
//

import Foundation
import UIKit

class GarageViewController: UIViewController {
    
    let userDefault = UserDefaultData.shared
    
    var collectionSkins:[String] = []

    let collectionSpeedStat = [7, 7, 7, 7]
    let collectionJumpStat = [7, 7, 7, 7]
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var settingView: SettingView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionSkins = userDefault.mySkinList
        // Background Blur
        let image = UIImage(named: "RobbyBack")
        backgroundView.image = image?.applyBlur_usingClamps(radius: 30)
        
        // Button
        backButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        backButton.layer.shadowOpacity = 1
        backButton.layer.shadowRadius = 20
        backButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: backButton.frame.width, height: backButton.frame.height)).cgPath
        
        settingButton.layer.shadowColor = UIColor.deliveryrunYellow?.cgColor
        settingButton.layer.shadowOpacity = 1
        settingButton.layer.shadowRadius = 20
        settingButton.layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: settingButton.frame.width, height: settingButton.frame.height)).cgPath
        
        // SettingView
        settingView.isHidden = true
        settingView.layer.opacity = 1.0
        
        
        // CollectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PlayerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionCell")
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
    }
    
    
    @IBAction func BackPressed(_ sender: UIButton) {
        let robby = UIStoryboard.init(name: "Robby", bundle: nil)
                guard let RobbyViewController = robby.instantiateViewController(withIdentifier: "RobbyViewController")as? RobbyViewController else {return}
        RobbyViewController.modalPresentationStyle = .fullScreen
                self.present(RobbyViewController, animated: false, completion: nil)
        
    }
    @IBAction func SettingPressed(_ sender: UIButton) {
        settingView.isHidden = false
    }
    
    
    @IBAction func BackWardPressed(_ sender: UIButton) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
// This part here
        if nextItem.row < collectionSkins.count {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
           
        }
    }
    @IBAction func ForwardPressed(_ sender: UIButton) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
// This part here
        if nextItem.row < collectionSkins.count {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
           
        }
    }
}

extension GarageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // CollectionNumbers
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionSkins.count
    }
    
    // Collection Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Cell Propery
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionCell", for: indexPath) as! PlayerCollectionCell
        cell.collectionName = collectionSkins[indexPath.row]
        cell.collectionImage.image = UIImage(named: collectionSkins[indexPath.row])
        cell.SpeedLabel.text = String(format: "%D", collectionSpeedStat[indexPath.row])
        cell.JumpLabel.text = String(format: "%D", collectionJumpStat[indexPath.row])
        cell.SpeedProgress.progress = Float(Double(collectionSpeedStat[indexPath.row]) / 10.0)
        cell.JumpProgress.progress = Float(Double(collectionJumpStat[indexPath.row]) / 10.0)
        
        return cell
        
    }
    
    // Collection Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let width: CGFloat = (collectionView.frame.width)
        let height: CGFloat = (collectionView.frame.height)
            return CGSize(width: width, height: height)
        }
    
}


// UIImage Blur

extension UIImage {
    
    func applyBlur_usingClamps(radius: CGFloat) -> UIImage {
        let context = CIContext()
        guard let ciImage = CIImage(image: self), let clampFilter = CIFilter(name: "CIAffineClamp") , let blurFilter = CIFilter(name: "CIGaussianBlur") else {
            return self
        }
        
        clampFilter.setValue(ciImage, forKey: kCIInputImageKey)
        
        blurFilter.setValue(clampFilter.outputImage, forKey: kCIInputImageKey)
        blurFilter.setValue(radius, forKey: kCIInputRadiusKey)
        guard let output = blurFilter.outputImage,
              let cgimg = context.createCGImage(output, from: ciImage.extent) else {
            return self
        }
        return UIImage(cgImage: cgimg)
    }
}
