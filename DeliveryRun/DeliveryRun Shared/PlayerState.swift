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
        playerNode.run(.applyForce(CGVector(dx: 0, dy: 250), duration: 0.5))
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {(timer) in
            self.hasFinishedJumping = true
        }
    }
}

// Landing State
class LandingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is LandingState.Type, is JumpingState.Type: return false
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
        
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
//            self.stateMachine?.enter(RunningState.self)
//        }
    }
}

// Breaking State
class BreakingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type, is DamageState.Type: return true
        default: return false
        }
    }
    
    let textures: Array<SKTexture> = (9..<11).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
//            self.stateMachine?.enter(RunningState.self)
//        }
    }
}

// Damage State
class DamageState: PlayerState {
    var isDamaged: Bool = false
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is DamageState.Type: return false
        default: return true
        }
    }
    
    let textures: Array<SKTexture> = (12..<14).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 2.0))} ()
    
    let action2 = SKAction.repeat(.sequence([
        .fadeAlpha(to: 0.5, duration: 0.01),
        .wait(forDuration: 0.25),
        .fadeAlpha(to: 1.0, duration: 0.01),
        .wait(forDuration: 0.25),
        ]), count: 5)
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(SKAction.group([action,action2]))
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            self.stateMachine?.enter(RunningState.self)
        }
        
    }
}

// God State
class GodState: PlayerState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GodState.Type: return false
        default: return true
        }
    }
    
    let action = SKAction.repeat(.sequence([
        .scale(to: 0.3, duration: 1),
        .scale(to: 0.5, duration: 1),
        .scale(to: 0.3, duration: 1)
    ]), count: 1)
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.run(action)
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.stateMachine?.enter(RunningState.self)
        }
    }
}
