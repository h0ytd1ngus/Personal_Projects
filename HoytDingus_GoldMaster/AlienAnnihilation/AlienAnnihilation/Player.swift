//
//  Player.swift
//  AlienAnnihilation
//
//  Created by Hoyt Dingus on 3/7/15.
//  Copyright (c) 2015 Hoyt Dingus. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation

final class Player : SKNode, Collision {
    
    
    //===================================Motion Manager===============================================//
    let motionManager: CMMotionManager = CMMotionManager()
    
    
    //===================================Audio Player===============================================//
    var audioplayer = AVAudioPlayer();
    
    
    //===================================Player===============================================//
    var ship  : SKSpriteNode? = nil;
    let shipName = "ship";
    var guns  : SKSpriteNode? = nil;
    
    
    //===================================Laser================================================//
    var laser : SKSpriteNode? = nil;
    
    
    //===================================Is Active============================================//
    var isActive : Bool = true;
    
    
    //===================================Init================================================//
    override init() {
        
        super.init();
        
        self.xScale = 0.25;
        self.yScale = 0.25;
        
    }
    
    required init? (coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder);
        
    }
    
    
    //===================================Player Setup========================================//
    func playerSetup() -> Bool {
        
        //set player graphics
        ship = SKSpriteNode(imageNamed: "tank_01.png");
        guns = SKSpriteNode(imageNamed: "gun_4.png");
        
        //add player graphics
        ship!.addChild(guns!);
        self.name = shipName;
        self.addChild(ship!);
        
        //Physics Body
        var shipBody : CGRect = CGRectMake(0.0, 0.0, ship!.frame.size.width, ship!.frame.size.height);
        self.ship!.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "tank_01.png"), size: shipBody.size);
        self.ship!.physicsBody?.dynamic = true;
        self.ship?.physicsBody?.allowsRotation = false;
        self.ship!.physicsBody?.affectedByGravity = false;
        self.ship!.physicsBody?.mass = 0.02;
        
        //Collision CATEGORY
        self.ship!.physicsBody!.categoryBitMask = GameScene.Colliders.PLAYER_MASK;
        
        //Setup Collision
        self.ship!.physicsBody?.contactTestBitMask = GameScene.Colliders.ALIEN_MASK | GameScene.Colliders.LASER_MASK | GameScene.Colliders.UPGRADE_MASK | GameScene.Colliders.WORLD_MASK;
        self.ship!.physicsBody!.collisionBitMask = 2;
        
        //Player Active
        isActive = true;
        
        return true;
        
    }
    
    
    //===================================Fire Lasers=========================================//
    func fireLasers() {
        
        laser = SKSpriteNode(imageNamed: "bullet_4.png");
        laser?.name = "PlayerLaser";
        
        var laserBody : CGRect = CGRectMake(0.0, 0.0, laser!.frame.size.width, laser!.frame.size.height);
        
        laser?.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "bullet_4.png"), size: laserBody.size);
        laser?.physicsBody?.categoryBitMask = GameScene.Colliders.LASER_MASK;
        laser?.physicsBody?.collisionBitMask = 2;
        laser?.physicsBody?.contactTestBitMask = GameScene.Colliders.ALIEN_MASK | GameScene.Colliders.ALIEN_LASER_MASK | GameScene.Colliders.WORLD_MASK;
        
        if (laser != nil && self.ship != nil) {
            
            var shoot : SKAction = SKAction.moveBy(CGVector(dx: 0.0, dy: 4000.0) , duration: 3.0);
            
            // Laser Sound
            var laserSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Laser", ofType: "wav")!);
            var error : NSError?;
           
            AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
            AVAudioSession.sharedInstance().setActive(true, error: nil)
            
            audioplayer = AVAudioPlayer(contentsOfURL: laserSound, error: &error)
            audioplayer.prepareToPlay()
            audioplayer.play()
            
            // Run Action
            laser!.runAction(shoot);
            
        }
        
        guns?.addChild(laser!);
        
    }
    
    
    //===================================Player Movement=========================================//
    func processUserMotionForUpdate(currentTime: CFTimeInterval) {
        
        if let motion = motionManager.accelerometerData {
            
            if (fabs(motion.acceleration.x) > 0.2) {
                
                ship!.physicsBody!.applyForce(CGVectorMake(40.0 * CGFloat(motion.acceleration.x), 0))
                
            }
        }
    }
    
    
    //===================================Handle Collisions=========================================//
    func handleCollisionWithObject(otherBody: SKPhysicsBody) {
        
        if ((otherBody.categoryBitMask | GameScene.Colliders.WORLD_MASK != 0 ) || (otherBody.categoryBitMask | GameScene.Colliders.ALIEN_MASK) != 0) {
        
                //******* What happens when a collision happens*********//
        
        }
    
    }
    
}
