//
//  Sound.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/11/02.
//

import Foundation
import AVFoundation

struct Sound {
    var audioPlayer: AVAudioPlayer
    
    init(audioPlayer: AVAudioPlayer) {
        self.audioPlayer = audioPlayer
    }
    
    mutating func playSound(soundName:String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.play()
        } catch {
            print("SoundError \(error)")
        }
    }
    
    mutating func stopSound() {
        audioPlayer.stop()
    }
}
