//
//  GarageViewController.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/24.
//

import Foundation
import UIKit

class GarageViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let players:[Player] = [
        Player(speed: 7, jump: 7, special: false, iamge:UIImage(named: "default")!),
        Player(speed: 5, jump: 9, special: false, iamge:UIImage(named: "bike")!),
        Player(speed: 7, jump: 7, special: true, iamge:UIImage(named: "scooter")!),
        Player(speed: 7, jump: 7, special: true, iamge:UIImage(named: "deliveryCar")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: image Blur 처리방식
        let image = UIImage(named: "RobbyBack")
        backgroundImage.image = image?.applyBlur_usingClamp(radius: 30)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PlayerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCollectionCell")
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
// This part here
        if nextItem.row < players.count {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
           
        }
    }
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
// This part here
        if nextItem.row < players.count {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
           
        }
    }
}

extension GarageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width: CGFloat = (collectionView.frame.width)
        let height: CGFloat =
        (collectionView.frame.height)
            
            return CGSize(width: width, height: height)
        }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell Property
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCollectionCell", for: indexPath) as! PlayerCollectionCell
        cell.image.image = players[indexPath.row].iamge
        return cell
    }
    
}

extension UIImage {
    
    func applyBlur_usingClamp(radius: CGFloat) -> UIImage {
        let context = CIContext()
        guard let ciImage = CIImage(image: self),
              let clampFilter = CIFilter(name: "CIAffineClamp"),
              let blurFilter = CIFilter(name: "CIGaussianBlur") else {
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

