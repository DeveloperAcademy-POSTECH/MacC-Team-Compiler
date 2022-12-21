//
//  ChapterViewController.swift
//  DeliveryRun iOS
//
//  Created by HWANG-C-K on 2022/12/21.
//

import UIKit

class ChapterViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "RobbyBack")
        backgroundImage.image = image?.applyBlur_usingClamp(radius: 50)
        
    }

}
