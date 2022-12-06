//
//  Sound.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/02.
//

import Foundation
import AVFoundation

class Sound {
    var backgroundPlayer: AVAudioPlayer
    var gameSoundPlayer: AVAudioPlayer
    
    
    static let shared:Sound = {
        let instance = Sound(backgroundPlayer: AVAudioPlayer(), gameSoundPlayer: AVAudioPlayer())
        return instance
    }()
    
    
    init(backgroundPlayer: AVAudioPlayer, gameSoundPlayer: AVAudioPlayer ) {
        self.backgroundPlayer = backgroundPlayer
        self.gameSoundPlayer = gameSoundPlayer
    }
    
    func playBackground(backgroundName:String) {
        let url = Bundle.main.url(forResource: backgroundName, withExtension: "wav")
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url!)
            backgroundPlayer.setVolume(0.7, fadeDuration: 1)
            backgroundPlayer.numberOfLoops = -1
            backgroundPlayer.play()
        } catch {
            print("SoundError \(error)")
        }
    }
    
    func playgameSound(gameSoundName: String) {
        let url = Bundle.main.url(forResource:  gameSoundName, withExtension: "wav")
        do {
            gameSoundPlayer = try AVAudioPlayer(contentsOf: url!)
            gameSoundPlayer.setVolume(1.0, fadeDuration: 1)
            gameSoundPlayer.play()
        } catch {
            print("GameSound Error \(error)")
        }
    }
    
    func stopBackground() {
        backgroundPlayer.setVolume(0.0, fadeDuration: 1)
        backgroundPlayer.numberOfLoops = 1
        backgroundPlayer.stop()
    }
    func stopGameSound() {
        gameSoundPlayer.setVolume(0.0, fadeDuration: 1)
        gameSoundPlayer.stop()
    }
}

// MARK: Sounds 0... 게임내 사운드를 담당
