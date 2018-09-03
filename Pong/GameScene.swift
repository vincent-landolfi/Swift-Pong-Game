//
//  GameScene.swift
//  Pong
//
//  Created by Vincent Landolfi on 2017-04-18.
//  Copyright © 2017 Vincent Landolfi. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var OpponentPaddle = SKSpriteNode()
    var PlayerPaddle = SKSpriteNode()
    
    var PlayerScore = SKLabelNode()
    var OpponentScore = SKLabelNode()
    
    var score = [Int]()
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        OpponentPaddle = self.childNode(withName: "OpponentPaddle") as! SKSpriteNode
        PlayerPaddle = self.childNode(withName: "PlayerPaddle") as! SKSpriteNode
        PlayerScore = self.childNode(withName: "PlayerScore") as! SKLabelNode
        OpponentScore = self.childNode(withName: "OpponentScore") as! SKLabelNode
        
        OpponentPaddle.position.y = (self.frame.height / 2) - 50
        PlayerPaddle.position.y = (-self.frame.height / 2) + 50
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    OpponentPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    PlayerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            } else {
                PlayerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
    func startGame() {
        score = [0,0]
        PlayerScore.text = "\(score[0])"
        OpponentScore.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0,y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
        if playerWhoWon == PlayerPaddle {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 30, dy: 30))
        } else if playerWhoWon == OpponentPaddle {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -30, dy: -30))
        }
        PlayerScore.text = "\(score[0])"
        OpponentScore.text = "\(score[1])"
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    OpponentPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    PlayerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            } else {
                PlayerPaddle.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        switch currentGameType {
        case .easy:
            OpponentPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .medium:
            OpponentPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .hard:
            OpponentPaddle.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .player2:
            
            break
        }
        
        if ball.position.y <= PlayerPaddle.position.y - 30 {
            addScore(playerWhoWon: OpponentPaddle)
        } else if ball.position.y >= OpponentPaddle.position.y + 30 {
            addScore(playerWhoWon: PlayerPaddle)
        }
    }
}
