//
//  GameScene.swift
//  AlienAnnihilation
//
//  Created by Hoyt Dingus on 3/5/15.
//  Copyright (c) 2015 Hoyt Dingus. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //===================================Collision IDs=========================================//
    struct Colliders {
        
        static let PLAYER_MASK  : UInt32 = 0x1 << 0;
        static let ALIEN_MASK   : UInt32 = 0x1 << 1;
        static let WORLD_MASK   : UInt32 = 0x1 << 2;
        static let LASER_MASK   : UInt32 = 0x1 << 3;
        static let UPGRADE_MASK : UInt32 = 0x1 << 4;
        static let ALIEN_LASER_MASK : UInt32 = 0x1 << 5;
        
    }
    
    
    //===================================Enum For Moves=========================================//
    enum Move : Int32 {
    
        case LEFT = 0
        case RIGHT
    
    }
    
    
    //===================================Scoring=========================================//
    var scoreBoard : SKLabelNode = SKLabelNode(fontNamed: "Futura Condensed Medium");
    var score : Int = 0;
    
    
    //===================================Lives=========================================//
    var lifeBoard : SKLabelNode = SKLabelNode (fontNamed: "Futura Condensed Medium");
    var lives : Int = 3;
    var GameOver : Bool = false;
    
    
    //===================================Contact Queue=========================================//
    var contactQueue = Array<SKPhysicsContact>()
    
    
    //===================================Audio Player=========================================//
    var audioplayer = AVAudioPlayer();
    
    
    //===================================Player Object=========================================//
    var player : Player? = nil;
    
    
    //====================================Alien Object=========================================//
    var alien : Alien? = nil;
    
    
    //=====================================Background==========================================//
    var background : SKSpriteNode? = nil;
    var gameWorld  : SKNode? = nil;
    
    
    //===================================didMoveToView=========================================//
    override func didMoveToView(view: SKView) {
        
        //view.showsPhysics = true;
        view.backgroundColor = UIColor.blackColor();
        startInvasion();
    
    }
    
    
    //===================================StartInvasion=========================================//
    func startInvasion() {
        
        // score board details
        scoreBoard.fontSize = 18;
        scoreBoard.fontColor = SKColor.greenColor();
        scoreBoard.text = NSString(format: "Score: %i", score) as String;
        scoreBoard.position = CGPoint(x: frame.size.width/1.35, y: size.height - (20 + scoreBoard.frame.size.height / 2));
        addChild(scoreBoard);
        
        // life board details
        lifeBoard.fontSize = 18;
        lifeBoard.fontColor = SKColor.greenColor();
        lifeBoard.text = NSString(format: "Lives: %i", lives) as String;
        lifeBoard.position = CGPoint(x: frame.size.width / 5, y: size.height - (20 + lifeBoard.frame.size.height / 2));
        addChild(lifeBoard);
        
        var musicSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("mp3", ofType: "mp3")!);
        var error : NSError?;
        
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        audioplayer = AVAudioPlayer(contentsOfURL: musicSound, error: &error)
        audioplayer.numberOfLoops = -1;
        audioplayer.prepareToPlay()
        audioplayer.play()
        
        gameWorld = SKNode();
        
        physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0, -10, frame.size.width, frame.size.height + 10));
        
        self.addChild(gameWorld!);
        
        // add background to the scene
        //background = SKSpriteNode(imageNamed: "1.jpg");
        
        //if (background != nil) {
            
            //background!.position = CGPoint(x:self.view!.frame.size.width / 2.0, y:self.view!.frame.size.height / 2.0);
            
            //println("backgroundframe=\(background!.frame.origin.x), \(background!.frame.origin.y), \(background!.frame.size.width), \(background!.frame.size.height)");
            
            // add the background to the scene
            //gameWorld!.addChild(background!);
            
        //}
        
        // add player to the scene
        player = Player();
        
        if ((player != nil) && (player!.playerSetup())) {
            
            player!.position = CGPointMake(self.view!.frame.size.width/2.0, self.view!.frame.size.height/10.0);
            gameWorld!.addChild(player!);
            player!.motionManager.startAccelerometerUpdates();
            
        }
        
        // add aliens to scene
        alien = Alien();
        
        if (alien != nil) {
            
            alien?.setupAliens(self.view!.frame.size);
            gameWorld?.addChild(alien!);
            
        }
        
        // set up the physicsWorld
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0);
        self.physicsWorld.contactDelegate = self;
        
    }
    
    
    //===================================touchesBegan=========================================//
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        /* Called when a touch begins */
        
        if (GameOver) {
           
            let newGame : GameScene = GameScene(size: size);
            self.view?.presentScene(newGame);
            
        }
        
        for touch: AnyObject in touches {
            
            let location = touch.locationInNode(self);
            
            let action   = SKAction.rotateByAngle(CGFloat(M_PI), duration:1);
            
            if (lives > 0){
            
                player?.fireLasers();
            
            }
            
        }
    }
    
    
    //===================================Did Begin Contact=============================//
    func didBeginContact(contact: SKPhysicsContact) {
        
        //if (contact != nil) {
            
            self.contactQueue.append(contact);
            
        //}
        
    }
    
    
    //===================================Handle Contact================================//
    func handleContact (contact: SKPhysicsContact){
        
        var bodyA = contact.bodyA;
        var bodyB = contact.bodyB;
        
        if(bodyA.categoryBitMask == Colliders.PLAYER_MASK && bodyB.categoryBitMask == Colliders.ALIEN_LASER_MASK) {
            
            //bodyA is the player
            var player = bodyA.node as? SKSpriteNode;
            var alienlaser = bodyB.node as? SKSpriteNode;
            
            if (player != nil && alienlaser != nil) {
            
                
                alienlaser!.removeFromParent();
                
                lives--;
                
                self.runAction(SKAction.playSoundFileNamed("PlayerExplosion.wav", waitForCompletion: false));
            
                lifeBoard.text = NSString(format: "Lives: %i", lives) as String;
                
                if (lives <= 0) {
                    
                    // game over
                    player!.removeFromParent();
                    gameOver();
                
                }
                
            }
            
        } else if (bodyA.categoryBitMask == Colliders.LASER_MASK && bodyB.categoryBitMask == Colliders.ALIEN_MASK) {
            
            //bodyA is the lazer
            var laser = bodyA.node as? SKSpriteNode;
            var alienNode = bodyB.node as? SKSpriteNode;
            
            if (laser != nil && alienNode != nil) {
                
                laser!.removeFromParent();
                alien!.numOfAliens--;
                alienNode!.removeFromParent();
                
                score += 25;
                
                if (score > 0) {
                    
                    scoreBoard.text = NSString(format: "Score: %i", score) as String;
                    
                }
                
                if (alien?.numOfAliens == 0 ){
                    
                    gameOver();
                    
                }
                
                self.runAction(SKAction.playSoundFileNamed("AlienExplosion.wav", waitForCompletion: false));
            
            }
            
        } else if (bodyA.categoryBitMask == Colliders.ALIEN_MASK && bodyB.categoryBitMask == Colliders.PLAYER_MASK) {
            
            //bodyA is the Alien
            var alienNode = bodyA.node as? SKSpriteNode;
            var player = bodyB.node as? SKSpriteNode;
            
            if (alienNode != nil && player != nil) {
                
                alienNode!.removeFromParent();
                
                alien!.numOfAliens--;
                lives--;
                
                self.runAction(SKAction.playSoundFileNamed("PlayerExplosion.wav", waitForCompletion: false));
                self.runAction(SKAction.playSoundFileNamed("AlienExplosion.wav", waitForCompletion: false));
                

                lifeBoard.text = NSString(format: "Lives: %i", lives) as String;
                
                if (lives <= 0) {

                    // game over
                    player!.removeFromParent();
                    gameOver();
                }
            
            }
            
        } else if (bodyB.categoryBitMask == Colliders.PLAYER_MASK && bodyA.categoryBitMask == Colliders.ALIEN_LASER_MASK) {
            
            //bodyB is the player
            var player = bodyB.node as? SKSpriteNode;
            var alienLaser = bodyA.node as? SKSpriteNode;
            
            if (player != nil && alienLaser != nil) {
                
                
                alienLaser!.removeFromParent();
               
                lives--;
            
                self.runAction(SKAction.playSoundFileNamed("PlayerExplosion.wav", waitForCompletion: false));
                
                lifeBoard.text = NSString(format: "Lives: %i", lives) as String;
                
                if (lives <= 0) {
                
                    // game over
                    player!.removeFromParent();
                    gameOver();
                
                }
                
            }
            
        } else if (bodyB.categoryBitMask == Colliders.LASER_MASK && bodyA.categoryBitMask == Colliders.ALIEN_MASK) {
            
            //bodyB is the lazer
            var laser = bodyB.node as? SKSpriteNode;
            var alienNode = bodyA.node as? SKSpriteNode;
            
            if (laser != nil && alienNode != nil) {
            
                laser!.removeFromParent();
                alien!.numOfAliens--;
                alienNode!.removeFromParent();
                
                score += 25;
                
                if (score > 0) {
                
                    scoreBoard.text = NSString(format: "Score: %i", score) as String;
               
                }
                
                self.runAction(SKAction.playSoundFileNamed("AlienExplosion.wav", waitForCompletion: false));
                
                if (alien?.numOfAliens == 0 ){
                    
                    gameOver();
                    
                }
                
            }
                
        } else if (bodyB.categoryBitMask == Colliders.ALIEN_MASK && bodyA.categoryBitMask == Colliders.PLAYER_MASK) {
            
            //bodyB is the Alien
            var alienNode = bodyB.node as? SKSpriteNode;
            var player = bodyA.node as? SKSpriteNode;
            
            self.runAction(SKAction.playSoundFileNamed("PlayerExplosion.wav", waitForCompletion: false));
            self.runAction(SKAction.playSoundFileNamed("AlienExplosion.wav", waitForCompletion: false));
            
            if (alienNode != nil && player != nil) {
                
                alienNode!.removeFromParent();
                alien!.numOfAliens--;
                lives--;
                                    
                lifeBoard.text = NSString(format: "Lives: %i", lives) as String;
                    
                if (lives <= 0) {
                    
                    player!.removeFromParent();
                    gameOver();
                
                }
                
            }
            
        } else if (bodyA.categoryBitMask == Colliders.ALIEN_LASER_MASK && bodyB.categoryBitMask == Colliders.WORLD_MASK) {
            
            var laser = bodyA.node as? SKSpriteNode;
            
            if laser != nil {
                
                laser!.removeFromParent();
                
            }
            
        } else if (bodyB.categoryBitMask == Colliders.ALIEN_LASER_MASK && bodyA.categoryBitMask == Colliders.WORLD_MASK) {
            
            var laser = bodyB.node as? SKSpriteNode;
            
            if laser != nil {
                
                laser!.removeFromParent();
                
            }
            
        } else if (bodyB.categoryBitMask == Colliders.LASER_MASK && bodyA.categoryBitMask == Colliders.WORLD_MASK){
            
            var laser = bodyB.node as? SKSpriteNode;
            
            if laser != nil {
                
                laser!.removeFromParent();
                
            }
            
        } else if (bodyA.categoryBitMask == Colliders.LASER_MASK && bodyB.categoryBitMask == Colliders.WORLD_MASK) {
            
            var laser = bodyA.node as? SKSpriteNode;
            
            if laser != nil {
                
                laser!.removeFromParent();
                
            }
            
        }
        
    }
    
    //===================================Game Over================================//
    func gameOver() {
        
        GameOver = true;
        
        var endGame : SKLabelNode = SKLabelNode (fontNamed: "Futura Condensed Medium");
        endGame.fontSize = 90;
        endGame.fontColor = SKColor.greenColor();
        endGame.text = NSString(string: "GAME OVER") as String;
        endGame.position = CGPoint(x: frame.size.width/2, y: frame.size.height / 2);
        self.addChild(endGame);
        
        var restart : SKLabelNode = SKLabelNode (fontNamed: "Futura Condensed Medium");
        restart.fontSize = 40;
        restart.fontColor = SKColor.greenColor();
        restart.text = NSString(string: "Tap To Play Again") as String;
        restart.position = CGPoint(x: frame.size.width/2, y: frame.size.height / 5);
        self.addChild(restart);
        
        
    }
    
    
    //===================================Contact Update================================//
    func contactForUpdate(currentTime: CFTimeInterval){
        
        for contact in self.contactQueue {
            
            self.handleContact(contact);
            
            if let index = (self.contactQueue as NSArray).indexOfObject(contact) as Int?{
            
                self.contactQueue.removeAtIndex(index);
            
            }
            
        }
        
    }
   
    
    //======================================Update============================================//
    override func update(currentTime: CFTimeInterval) {
        
        alien!.moveAliensUpdate(currentTime);
        
        if (player != nil) {
            
            player!.processUserMotionForUpdate(currentTime);
        
        }
        
        contactForUpdate(currentTime);
    
    }
}
