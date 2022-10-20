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
    
    let textures: Array<SKTexture> = (9..<14).map({ return "player\($0)"}).map(SKTexture.init)
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
        return false
    }
    
    let textures: Array<SKTexture> = (2..<4).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.3))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        playerNode.run(.applyForce(CGVector(dx: 0, dy: 500), duration: 0.3))
        
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { (timer) in
            self.hasFinishedJumping = true
            self.stateMachine?.enter(LandingState.self)
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
    
    let textures: Array<SKTexture> = (5..<7).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.stateMachine?.enter(RunningState.self)
        }
    }
}

// Breaking State
class BreakingState: PlayerState {
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is RunningState.Type: return true
        default: return false
        }
    }
    
    let textures: Array<SKTexture> = (8..<10).map({ return "player\($0)"}).map(SKTexture.init)
    lazy var action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.5))} ()
    
    override func didEnter(from previousState: GKState?) {
        
        playerNode.removeAction(forKey: characterAnimationKey)
        playerNode.run(action, withKey: characterAnimationKey)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.stateMachine?.enter(RunningState.self)
        }
    }
}
