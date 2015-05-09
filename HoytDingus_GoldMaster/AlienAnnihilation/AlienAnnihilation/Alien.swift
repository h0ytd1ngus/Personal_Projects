//
//  Alien.swift
//  AlienAnnihilation
//
//  Created by Hoyt Dingus on 3/7/15.
//  Copyright (c) 2015 Hoyt Dingus. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion
import AVFoundation

final class Alien : SKNode {
    
    var gameWorldSize : CGSize? = nil;
    
    //===================================Alien Enum for Type===================================//
    enum AlienType {
        case green;
        case purple;
        case red;
    }
    
    
    //===================================Alien Enum for Moves===================================//
    enum AlienMoves {
        case Right;
        case Left;
        case DownThenRight;
        case DownThenLeft;
        case None;
    }
    
    //===================================Alien Enum for Moves===================================//
    var audioplayer = AVAudioPlayer();
    
    
    //===================================Alien Moves & Timing===================================//
    var alienMoves : AlienMoves = .Right;
    var timeOfPrevMove : CFTimeInterval = 0.0;
    let timePerMove : CFTimeInterval = 1.0;
    var prevFireTime : CFTimeInterval = 0.0;
    let fireTime : CFTimeInterval = 2.0;
    
    
    
    
    //====================================Alien Size and Spacing===============================//
    let alienSize = CGSize(width:200, height:200);
    let alienGridSpacing = CGSize(width:200, height:25);
    let alienRowCount = 5;
    let alienColCount = 5;
    let alienName = "alien";
    var laser : SKSpriteNode? = nil;
    
    
    //====================================number of aliens===============================//
    var numOfAliens : Int = 24;
    
    
    //====================================Make Aliens====================================//
    func makeAlienOfType(alienType: AlienType) -> (SKSpriteNode) {
        
        // Which Alien to make
        var alien : SKSpriteNode;
        
        switch(alienType) {
        
            case .green:
                var texture : SKTexture = SKTexture(imageNamed: "green.png");
                alien = SKSpriteNode(texture: texture, size:alienSize);
                //alienArray.addObject(alien);
        
            case .purple:
                var texture : SKTexture = SKTexture(imageNamed: "purple");
                alien = SKSpriteNode(texture: texture, size:alienSize);
                //alienArray.addObject(alien);
        
            case .red:
                var texture : SKTexture = SKTexture(imageNamed: "red");
                alien = SKSpriteNode(texture: texture, size:alienSize);
                //alienArray.addObject(alien);
        
            default:
                var texture : SKTexture = SKTexture(imageNamed: "green.png");
                alien = SKSpriteNode(texture: texture, size:alienSize);
                //alienArray.addObject(alien);
        
        }
        
        alien.name = alienName;
        
        return alien;
    }
    
    
    //===================================Init================================================//
    override init() {
        
        super.init();
        
        self.xScale = 0.1;
        self.yScale = 0.1;
        
    }
    
    required init? (coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
    }
    
    
    //====================================Setup Aliens====================================//
    func setupAliens(gameWorldSize: CGSize) {
        
        self.gameWorldSize = gameWorldSize;
        
        let baseOrigin = CGPoint(x: self.gameWorldSize!.width / 2 , y: self.gameWorldSize!.height * 4);
        
        for var row = 1; row <= alienRowCount; row++ {
            
            var alienType: AlienType;
            
            if row % 3 == 0 {
            
                alienType = .green;
            
            } else if row % 3 == 1 {
            
                alienType = .purple;
            
            } else {
                
                alienType = .red;
            }
        
            
            // Alien position
            let alienPositionY = CGFloat(row) * (alienSize.height * 3) + baseOrigin.y;
            var alienPosition = CGPoint(x:baseOrigin.x, y:alienPositionY);
            
            for var collumn = 1; collumn <= alienColCount; collumn++ {
                
                var alien = makeAlienOfType(alienType);
                
                alienPosition = CGPoint(x: alienPosition.x + alienSize.width + alienGridSpacing.width, y: alienPositionY);
                
                if (alienType == .green) {
                
                    alien.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "green.png"), size: alien.size);
                    
                } else if (alienType == .red){
                
                    alien.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "red.png"), size: alien.size);
                    
                } else if (alienType == .purple) {
                
                    alien.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "purple.png"), size: alien.size);
                    
                }
                
                alien.physicsBody!.collisionBitMask = 1;
                alien.physicsBody!.contactTestBitMask = GameScene.Colliders.PLAYER_MASK | GameScene.Colliders.LASER_MASK | GameScene.Colliders.WORLD_MASK;
                alien.physicsBody!.categoryBitMask = GameScene.Colliders.ALIEN_MASK;
                alien.physicsBody!.allowsRotation = false;
                alien.position = alienPosition;
                addChild(alien);
                
            }
        }
    }
    
    //====================================Aliens Move Here======================================//
    func moveAliensUpdate(curTime: CFTimeInterval) {
        
        if (curTime - timeOfPrevMove < timePerMove) {
            
            return;
            
        }
        
        for (var i:Int = 0; i < self.children.count; i++) {
            
            var node : SKSpriteNode = self.children[i] as! SKSpriteNode;
            
            switch self.alienMoves {
            
                case .Right:
                    node.position = CGPoint(x: node.position.x + 100, y: node.position.y);
                
                case .Left:
                    node.position = CGPoint(x: node.position.x - 100, y: node.position.y);
                
                case .DownThenLeft, .DownThenRight:
                    node.position = CGPoint(x: node.position.x, y: node.position.y - 100);
                
                case .None:
                    break;
                
                default:
                    break;
                
            }
            
            if (prevFireTime + fireTime < curTime){
                
                var alienArray = NSMutableArray();
                
                var randomAlien = Int(arc4random_uniform(UInt32(numOfAliens)));
            
                var Node : SKSpriteNode = self.children[randomAlien] as! SKSpriteNode;
                
                if (numOfAliens > -1){
                
                    fireLasers(Node);
                
                }
                
                prevFireTime = curTime;
                
            }
            
            self.timeOfPrevMove = curTime;
        }
        
        alienMoveDirection();
        
    }
    
    
    //====================================Aliens Direction======================================//
    func alienMoveDirection() {
        
        var alienDirection: AlienMoves = alienMoves;
        
        if (alienDirection == AlienMoves.DownThenRight) {
            
            alienDirection = AlienMoves.Right;
            
        } else if (alienDirection == AlienMoves.DownThenLeft) {
            
            alienDirection = AlienMoves.Left;
        }
        
        for (var i:Int = 0; i < self.children.count; i++) {
            
            var node : SKSpriteNode = self.children[i] as! SKSpriteNode;

            // check if we've hit a wall
            var maxX : CGFloat = node.scene!.size.width / self.xScale;
            
            
            if ((alienDirection == AlienMoves.Right) && (CGRectGetMaxX(node.frame) >= maxX)) {
                
                alienDirection = AlienMoves.DownThenLeft;
                break;
            
            } else if ((alienDirection == AlienMoves.Left) && (CGRectGetMinX(node.frame) <= 1.0)) {
                
                alienDirection = AlienMoves.DownThenRight;
                break;
            }
        }
        
        if (alienDirection != alienMoves) {

            alienMoves = alienDirection;
        
        }
    }
    
    //====================================Aliens Laser====================================//
    func fireLasers(node: SKSpriteNode) {
        
        /// bool is firing
        laser = SKSpriteNode(imageNamed: "bullet_3.png");
        laser!.name = "AlienLaser";
        
        var parentScene : SKScene = self.parent!.parent! as! SKScene;
        
        laser!.position = CGPointMake(node.position.x, node.position.y);
        
        var position = node.position;
        laser!.zPosition = 100000000;
        
        laser!.xScale = 1;
        laser!.yScale = 1;
        
        laser!.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bullet_3.png"), size: laser!.size);
        laser!.physicsBody!.categoryBitMask = GameScene.Colliders.ALIEN_LASER_MASK;
        laser!.physicsBody!.collisionBitMask = 0x1 << 5;
        laser!.physicsBody!.allowsRotation = false;
        laser!.physicsBody!.contactTestBitMask = GameScene.Colliders.PLAYER_MASK | GameScene.Colliders.LASER_MASK | GameScene.Colliders.WORLD_MASK;
        
        var laserSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Light_Laser_Pistol", ofType: "wav")!);
        var error : NSError?;
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil);
        AVAudioSession.sharedInstance().setActive(true, error: nil);
        
        audioplayer = AVAudioPlayer(contentsOfURL: laserSound, error: &error);
        audioplayer.prepareToPlay();
        audioplayer.play();
        
        self.addChild(laser!);
        
        if (laser != nil) {
            
            var shoot : SKAction = SKAction.moveBy(CGVector(dx: 0.0, dy: -1333.0) , duration: 1);

            var temp = laser!;
            
            laser!.runAction(SKAction.repeatActionForever(shoot));
            
        }
    }
    
}
