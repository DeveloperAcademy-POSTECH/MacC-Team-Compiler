//
//  GarageViewController.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/12/04.
//

import Foundation
import UIKit

class GarageViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var settingView: SettingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
