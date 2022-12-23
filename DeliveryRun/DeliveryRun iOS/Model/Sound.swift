//
//  Sound.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/02.
//

import Foundation
import AVFoundation

class GameSound {
    var gameSound:AVAudioPlayer
    
    static let shared:GameSound = {
        let instance = GameSound(gameSoundPlayer: AVAudioPlayer())
        return instance
    }()
    
    init(gameSoundPlayer: AVAudioPlayer) {
        self.gameSound = AVAudioPlayer()
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource:  soundName, withExtension: "wav")
        do {
            gameSound = try AVAudioPlayer(contentsOf: url!)
            gameSound.play()
        } catch {
            print("GameSound Error \(error)")
        }
    }
    func gameSoundOn() {
        gameSound.setVolume(1.0, fadeDuration: 1.0)
    }
    
    func gameSoundOff() {
        gameSound.setVolume(0.0, fadeDuration: 1.0)
    }
}
class BackgroundSound {
    
    var backgroundSound:AVAudioPlayer
    
    static let shared:BackgroundSound = {
        let instance = BackgroundSound(backgroundPlayer: AVAudioPlayer())
        return instance
    }()
    
    
    init(backgroundPlayer: AVAudioPlayer) {
        self.backgroundSound = AVAudioPlayer()
    }
    
    func playSound(soundName:String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        do {
            backgroundSound = try AVAudioPlayer(contentsOf: url!)
            backgroundSound.play()
        } catch {
            print("SoundError \(error)")
        }
    }
    
    func changeBackgroundMusic() {
        backgroundSound.stop()
        playSound(soundName: "InGameMusic")
    }
    
    func backgroundSoundOn() {
        backgroundSound.setVolume(1.0, fadeDuration: 1)
        backgroundSound.numberOfLoops = -1
    }
    
    func backgroundSoundOff() {
        backgroundSound.setVolume(0.0, fadeDuration: 1)
        backgroundSound.numberOfLoops = 1
        backgroundSound.stop()
    }
}

// MARK: Sounds 0... 게임내 사운드를 담당
