//
//  GameScene.swift
//  BuddyCade
//
//  Created by Fu on 11/5/16.
//  Copyright © 2016 BuddyCade. All rights reserved.
//

import SpriteKit
import GameplayKit
import MultipeerConnectivity

class GameScene: SKScene {
    
    var ball = SKSpriteNode();
    var enemy = SKSpriteNode();
    var main = SKSpriteNode();
    
    var topLabel = SKLabelNode();
    var bottomLabel = SKLabelNode();
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var score = [Int]()
    //var appDelegate: AppDelegate!
    
    override func sceneDidLoad() {

        //appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        startGame();
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "bottom") as! SKSpriteNode
        enemy = self.childNode(withName: "top") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame);
        border.friction = 0;
        border.restitution = 1;
        self.physicsBody = border;
    }
    
    func startGame() {
        score = [0,0];
        
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        var winnerScore = 0;
        
        if playerWhoWon == main {
            score[0] += 1;
            winnerScore = score[0]
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        }
        else if (playerWhoWon == enemy) {
            score[1] += 1
            winnerScore = score[1]
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
        
        
        
        /*let messageData = ["player": playerWhoWon, "score": winnerScore] as [String : Any]
        
        do {
            let messageDict = JSONSerialization.data(withJSONObject: messageData, options: JSONSerialization.WritingOptions.prettyPrinted)
        }
        catch {
            
        } 
        
        
        appDelegate.mpcHandler.session.sendData(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: nil)*/ //----how to get this back to GameViewController.swift??? idk
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if (!(location.x + 100 >= self.frame.width/2 || location.x - 100 <= -self.frame.width/2))
            {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if (!(location.x + 100 >= self.frame.width/2 || location.x - 100 <= -self.frame.width/2))
            {
                main.run(SKAction.moveTo(x: location.x, duration: 0))
            }
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        if (ball.position.y <= main.position.y - 70) {
           addScore(playerWhoWon: enemy)
            
        }
        else if (ball.position.y >= enemy.position.y + 70) {
            addScore(playerWhoWon: main)
            
        }
        
        
    }
}
