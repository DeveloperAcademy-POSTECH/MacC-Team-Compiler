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

//class SoundController {
//
//    var sounds = [
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "background"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "1"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "2"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "3"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "4"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "5"),
//    Sound(audioPlayer: AVAudioPlayer(), soundName: "6")
//    ]
//
//    init() {
//        soundOff()
//    }
//
//    func getSound(name: String) {
//        if let soundNumber = sounds.firstIndex(where: {$0.soundName == name}) {
//            sounds[soundNumber].playSound()
//        }
//    }
//
//    func pauseSound(name: String) {
//        if let soundNumber = sounds.firstIndex(where: {$0.soundName == name}) {
//            sounds[soundNumber].stopSound()
//        }
//    }
//    func soundOn() {
//        for sound in sounds {
//            sound.audioPlayer.volume = 1.0
//        }
//    }
//    func soundOff() {
//        for sound in sounds {
//            sound.audioPlayer.volume = 0
//        }
//    }
//}
