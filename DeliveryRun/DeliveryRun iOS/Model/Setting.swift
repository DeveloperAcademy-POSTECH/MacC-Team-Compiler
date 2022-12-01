//
//  Setting.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/29.
//

import Foundation

class Setting {
    let backgroundMusic:Bool
    let inGameSound:Bool
    
    init(backgroundMusic: Bool, inGameSound: Bool) {
        self.backgroundMusic = backgroundMusic
        self.inGameSound = inGameSound
    }
}
