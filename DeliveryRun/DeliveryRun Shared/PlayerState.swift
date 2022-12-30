//
//  PlayerState.swift
//  DeliveryRun iOS
//
//  Created by David_ADA on 2022/10/19.
//

import Foundation
import GameplayKit

fileprivate let characterAnimationKey = "SpriteKitAnimation"

class PlayerState: GKState {
    unowned var playerNode: SKNode
    
    init(playerNode: SKNode) {
        self.playerNode = playerNode
        super.init()
    }
}

// Running State
class RunningState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        //MARK: PreviousState PresentState 진입 가능여부 - True경우 진입가능
        case is RunningState.Type: return false
        default: return true
        }
    }
    
    let textures: Array<SKTexture> = (0..<2).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with:textures, timePerFrame: 0.1))} ()
    
    override func didEnter(from previousState: GKState?) {
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

// Jumping State
class JumpingState: PlayerState {
    var hasFinishedJumping: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if hasFinishedJumping && stateClass is LandingState.Type { return true }
        if hasFinishedJumping && stateClass is DamageState.Type { return true }
        return false
    }
    
    let textures: Array<SKTexture> = (3..<5).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        playerNode.physicsBody?.applyImpulse(CGVector(dx:0, dy:100))
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {(timer) in
            self.hasFinishedJumping = true
        }
    }
}

// Landing State
class LandingState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type,is DamageState.Type, is JumpingState.Type: return false
        default: return true
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        stateMachine?.enter(RunningState.self)
    }
}

// Acceling State
class AccelingState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type, is JumpingState.Type: return true
        default: return false
        }
    }
    
    let textures: Array<SKTexture> = (6..<8).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    override func didEnter(from previousState: GKState?) {
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
    }
}

// Breaking State
class BreakingState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type, is JumpingState.Type, is DamageState.Type: return true
        default: return false
        }
    }
    
    let textures: Array<SKTexture> = (9..<11).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
    }
}

// Damage State
class DamageState: PlayerState {
    
    var isDamaged: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        
        if isDamaged { return false }
        switch stateClass {
        case is RunningState.Type, is JumpingState.Type: return true
        default: return false
        }
    }
    
    let textures: Array<SKTexture> = (12..<14).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        isDamaged = true
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            self.isDamaged = false
            self.stateMachine?.enter(RunningState.self)
        }
    }
}


