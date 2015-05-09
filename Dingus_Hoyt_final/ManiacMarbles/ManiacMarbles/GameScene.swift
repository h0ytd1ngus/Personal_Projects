//
//  GameScene.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/11/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import SpriteKit
import UIKit
import CoreMotion

class GameScene: SKScene, UIAlertViewDelegate, SKPhysicsContactDelegate {
    
    
    //Collision Types
    enum ColTypes: UInt32 {
       
        case marbleCategory = 1
        case worldCategory = 2
        case wallCategory = 4
        case goalCategory = 8
        
    }
    
    var Level = NSUserDefaults.standardUserDefaults().integerForKey("level")
    
    //Misc Vars
    var levelComplete = false;
    var alert = UIAlertView()
    
    var didWin:Bool = false
    
    let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration: 1)
    
    override func didMoveToView(view: SKView) {
        
        alert.delegate = self
        
        //view.showsPhysics = true;
        self.backgroundColor = SKColor.blackColor()
        self.physicsWorld.contactDelegate = self
        
        
        //Set Screen Bounds
        self.physicsBody? = SKPhysicsBody(edgeLoopFromRect: self.frame);
        self.physicsBody?.dynamic = false
        self.physicsBody?.categoryBitMask = ColTypes.worldCategory.rawValue
        self.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
     
        
        // Create Sprites
        let level1 = childNodeWithName("level1");
        
        
        // Marble
        
        
        var marbleString:String? = NSUserDefaults.standardUserDefaults().stringForKey("marble")
        
        if(marbleString == nil) {
            
            marbleString = "blueMarble"
            
        }
        
        let marbleSprite = SKSpriteNode()
        let marble = childNodeWithName(marbleString!);
        if marbleString == "redMarble" {
            
            let blueMarble = childNodeWithName("blueMarble")
            let greenMarble = childNodeWithName("greenMarble")
            
            blueMarble!.removeFromParent()
            greenMarble!.removeFromParent()
            
        } else if marbleString == "blueMarble" {
            
            let redMarble = childNodeWithName("redMarble")
            let greenMarble = childNodeWithName("greenMarble")
            
            redMarble!.removeFromParent()
            greenMarble!.removeFromParent()
        
        } else {
            
            let blueMarble = childNodeWithName("blueMarble")
            let redMarble = childNodeWithName("redMarble")
            
            redMarble!.removeFromParent()
            blueMarble!.removeFromParent()
        
        }
        
        if marble != nil {
            
            marbleSprite.physicsBody? = SKPhysicsBody(circleOfRadius: marble!.frame.width/2);
            marbleSprite.physicsBody?.usesPreciseCollisionDetection = true
            marbleSprite.physicsBody?.dynamic = true
            marbleSprite.physicsBody?.categoryBitMask = ColTypes.marbleCategory.rawValue
            marbleSprite.physicsBody?.collisionBitMask = ColTypes.wallCategory.rawValue | ColTypes.goalCategory.rawValue | ColTypes.worldCategory.rawValue
            marbleSprite.physicsBody?.contactTestBitMask = ColTypes.wallCategory.rawValue | ColTypes.goalCategory.rawValue | ColTypes.worldCategory.rawValue
            
            marble!.addChild(marbleSprite)
            
        }
        
        
        //Back Button
        let back = childNodeWithName("backButton");

        
        // Goal
        let goal = childNodeWithName("goal");
        let goalSprite = SKSpriteNode()
        if goal != nil{
            
            goal!.physicsBody? = SKPhysicsBody(circleOfRadius: goal!.frame.width/2);
            goal!.physicsBody?.usesPreciseCollisionDetection = true
            goal!.physicsBody?.dynamic = false
            goal!.physicsBody?.categoryBitMask = ColTypes.goalCategory.rawValue
            goal!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            goal!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        
        // Walls
        let wall = childNodeWithName("wall");
        if  wall != nil {
            wall!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall!.frame.width, wall!.frame.height));
            wall!.physicsBody?.usesPreciseCollisionDetection = true
            wall!.physicsBody?.dynamic = false
            wall!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
            
        let wall2 = childNodeWithName("wall2");
        if  wall2 != nil {
            wall2!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall2!.frame.width, wall2!.frame.height));
            wall2!.physicsBody?.usesPreciseCollisionDetection = true
            wall2!.physicsBody?.dynamic = false
            wall2!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall2!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall2!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall3 = childNodeWithName("wall3");
        if  wall3 != nil {
            wall3!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall3!.frame.width, wall3!.frame.height));
            wall3!.physicsBody?.usesPreciseCollisionDetection = true
            wall3!.physicsBody?.dynamic = false
            wall3!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall3!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall3!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall4 = childNodeWithName("wall4");
        if  wall4 != nil {
            wall4!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall4!.frame.width, wall4!.frame.height));
            wall4!.physicsBody?.usesPreciseCollisionDetection = true
            wall4!.physicsBody?.dynamic = false
            wall4!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall4!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall4!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall5 = childNodeWithName("wall5");
        if  wall5 != nil {
            wall5!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall5!.frame.width, wall5!.frame.height));
            wall5!.physicsBody?.usesPreciseCollisionDetection = true
            wall5!.physicsBody?.dynamic = false
            wall5!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall5!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall5!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall6 = childNodeWithName("wall6");
        if  wall6 != nil {
            wall6!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall6!.frame.width, wall6!.frame.height));
            wall6!.physicsBody?.usesPreciseCollisionDetection = true
            wall6!.physicsBody?.dynamic = false
            wall6!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall6!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall6!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall7 = childNodeWithName("wall7");
        if  wall7 != nil {
            wall7!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall7!.frame.width, wall7!.frame.height));
            wall7!.physicsBody?.usesPreciseCollisionDetection = true
            wall7!.physicsBody?.dynamic = false
            wall7!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall7!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall7!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall8 = childNodeWithName("wall8");
        if  wall8 != nil {
            wall8!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall8!.frame.width, wall8!.frame.height));
            wall8!.physicsBody?.usesPreciseCollisionDetection = true
            wall8!.physicsBody?.dynamic = false
            wall8!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall8!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall8!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall9 = childNodeWithName("wall9")
        if  wall9 != nil {
            wall9!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall9!.frame.width, wall9!.frame.height));
            wall9!.physicsBody?.usesPreciseCollisionDetection = true
            wall9!.physicsBody?.dynamic = false
            wall9!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall9!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall9!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall10 = childNodeWithName("wall10")
        if  wall10 != nil {
            wall10!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall10!.frame.width, wall10!.frame.height));
            wall10!.physicsBody?.usesPreciseCollisionDetection = true
            wall10!.physicsBody?.dynamic = false
            wall10!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall10!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall10!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall11 = childNodeWithName("wall11")
        if  wall11 != nil {
            wall11!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall11!.frame.width, wall11!.frame.height));
            wall11!.physicsBody?.usesPreciseCollisionDetection = true
            wall11!.physicsBody?.dynamic = false
            wall11!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall11!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall11!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall12 = childNodeWithName("wall12")
        if  wall12 != nil {
            wall12!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall12!.frame.width, wall12!.frame.height));
            wall12!.physicsBody?.usesPreciseCollisionDetection = true
            wall12!.physicsBody?.dynamic = false
            wall12!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall12!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall12!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall13 = childNodeWithName("wall13")
        if  wall13 != nil {
            wall13!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall13!.frame.width, wall13!.frame.height));
            wall13!.physicsBody?.usesPreciseCollisionDetection = true
            wall13!.physicsBody?.dynamic = false
            wall13!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall13!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall13!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall14 = childNodeWithName("wall14")
        if  wall14 != nil {
            wall14!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall14!.frame.width, wall14!.frame.height));
            wall14!.physicsBody?.usesPreciseCollisionDetection = true
            wall14!.physicsBody?.dynamic = false
            wall14!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall14!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall14!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall15 = childNodeWithName("wall15")
        if  wall15 != nil {
            wall15!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall15!.frame.width, wall15!.frame.height));
            wall15!.physicsBody?.usesPreciseCollisionDetection = true
            wall15!.physicsBody?.dynamic = false
            wall15!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall15!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall15!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall16 = childNodeWithName("wall16")
        if  wall16 != nil {
            wall16!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall16!.frame.width, wall16!.frame.height));
            wall16!.physicsBody?.usesPreciseCollisionDetection = true
            wall16!.physicsBody?.dynamic = false
            wall16!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall16!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall16!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall17 = childNodeWithName("wall17")
        if  wall17 != nil {
            wall17!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall17!.frame.width, wall17!.frame.height));
            wall17!.physicsBody?.usesPreciseCollisionDetection = true
            wall17!.physicsBody?.dynamic = false
            wall17!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall17!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall17!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall18 = childNodeWithName("wall18")
        if  wall18 != nil {
            wall18!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall18!.frame.width, wall18!.frame.height));
            wall18!.physicsBody?.usesPreciseCollisionDetection = true
            wall18!.physicsBody?.dynamic = false
            wall18!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall18!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall18!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall19 = childNodeWithName("wall19")
        if  wall19 != nil {
            wall19!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall19!.frame.width, wall19!.frame.height));
            wall19!.physicsBody?.usesPreciseCollisionDetection = true
            wall19!.physicsBody?.dynamic = false
            wall19!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall19!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall19!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let wall20 = childNodeWithName("wall20")
        if  wall20 != nil {
            wall20!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(wall20!.frame.width, wall20!.frame.height));
            wall20!.physicsBody?.usesPreciseCollisionDetection = true
            wall20!.physicsBody?.dynamic = false
            wall20!.physicsBody?.categoryBitMask = ColTypes.wallCategory.rawValue
            wall20!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            wall20!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let outOfBounds = childNodeWithName("outOfBounds")
        if  outOfBounds != nil {
            outOfBounds!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(outOfBounds!.frame.width, outOfBounds!.frame.height));
            outOfBounds!.physicsBody?.usesPreciseCollisionDetection = true
            outOfBounds!.physicsBody?.dynamic = false
            outOfBounds!.physicsBody?.categoryBitMask = ColTypes.worldCategory.rawValue
            outOfBounds!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            outOfBounds!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let outOfBounds2 = childNodeWithName("outOfBounds2")
        if  outOfBounds2 != nil {
            outOfBounds2!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(outOfBounds2!.frame.width, outOfBounds2!.frame.height));
            outOfBounds2!.physicsBody?.usesPreciseCollisionDetection = true
            outOfBounds2!.physicsBody?.dynamic = false
            outOfBounds2!.physicsBody?.categoryBitMask = ColTypes.worldCategory.rawValue
            outOfBounds2!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            outOfBounds2!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let outOfBounds3 = childNodeWithName("outOfBounds3")
        if  outOfBounds3 != nil {
            outOfBounds3!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(outOfBounds3!.frame.width, outOfBounds3!.frame.height));
            outOfBounds3!.physicsBody?.usesPreciseCollisionDetection = true
            outOfBounds3!.physicsBody?.dynamic = false
            outOfBounds3!.physicsBody?.categoryBitMask = ColTypes.worldCategory.rawValue
            outOfBounds3!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            outOfBounds3!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        let outOfBounds4 = childNodeWithName("outOfBounds4")
        if  outOfBounds4 != nil {
            outOfBounds4!.physicsBody? = SKPhysicsBody(rectangleOfSize: CGSizeMake(outOfBounds4!.frame.width, outOfBounds4!.frame.height));
            outOfBounds4!.physicsBody?.usesPreciseCollisionDetection = true
            outOfBounds4!.physicsBody?.dynamic = false
            outOfBounds4!.physicsBody?.categoryBitMask = ColTypes.worldCategory.rawValue
            outOfBounds4!.physicsBody?.collisionBitMask = ColTypes.marbleCategory.rawValue
            outOfBounds4!.physicsBody?.contactTestBitMask = ColTypes.marbleCategory.rawValue
        }
        
        // Add Animation to Marble
        let spin = SKAction.rotateByAngle(CGFloat(M_PI), duration:1);
        marble!.runAction(SKAction.repeatActionForever(spin));
        
        
        //Core Motion and Accelerometer
        let marbleSpeed = 3
        let motionManager = CMMotionManager();
        
        if (motionManager.accelerometerAvailable) {
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
                
                (data, error) in
                    
                    var destinY = (CGFloat(data.acceleration.x))
                    var destinX = (CGFloat(data.acceleration.y * -1) )
                    marble!.zPosition = 0.1
                    motionManager.accelerometerActive == true;
                    
                    marble!.physicsBody!.applyImpulse(CGVectorMake(destinX, destinY))
                
            
            }
        
        }
    
    }
    
    
    // Lose Alert
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(didWin == true) {
            
            if buttonIndex == 0 {
                
                if Level == 1 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 2");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else if Level == 2 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 3");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else if Level == 3 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(4, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 4");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else if Level == 4 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(5, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 5");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else if Level == 5 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(6, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 6");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else if Level == 6 {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(7, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 7");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                
                } else {
                    
                    NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "level")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    var currentLevel = GameScene(fileNamed: "gameScene 1");
                    currentLevel.scaleMode = SKSceneScaleMode.AspectFit
                    self.scene!.view!.presentScene(currentLevel, transition: transition)
                    
                }
                    
            } else {
                
                var done = MainMenu(fileNamed: "MainMenu")
                done.scaleMode = SKSceneScaleMode.AspectFit
                self.scene!.view!.presentScene(done, transition: transition)
            }
            
        } else {
            
            if buttonIndex == 0 {
                
                var playAgain = LevelSelect(fileNamed: "LevelSelect");
                playAgain.scaleMode = SKSceneScaleMode.AspectFit
                self.scene!.view!.presentScene(playAgain, transition: transition)
                
            } else {
                
                var noPlay = MainMenu(fileNamed: "MainMenu")
                noPlay.scaleMode = SKSceneScaleMode.AspectFit
                self.scene!.view!.presentScene(noPlay, transition: transition)
                
            }
            
        }
        
    }
    
    
    //Collision Detection
    func didBeginContact(contact: SKPhysicsContact) {
        
        var bodyA:SKPhysicsBody = contact.bodyA
        var bodyB:SKPhysicsBody = contact.bodyB
        
        
        
        //When Marble Hits the Wall
        if ((bodyA.categoryBitMask == ColTypes.marbleCategory.rawValue) && (bodyB.categoryBitMask == ColTypes.wallCategory.rawValue || (bodyB.categoryBitMask == ColTypes.marbleCategory.rawValue) && (bodyA.categoryBitMask == ColTypes.wallCategory.rawValue)) {
            
            let hitWall = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: true);
            self.runAction(hitWall);
            
        }
        
        //When Marble Reaches the Goal
        if ((bodyA.categoryBitMask == ColTypes.marbleCategory.rawValue) && (bodyB.categoryBitMask == ColTypes.goalCategory.rawValue) || (bodyB.categoryBitMask == ColTypes.marbleCategory.rawValue) && (bodyA.categoryBitMask == ColTypes.goalCategory.rawValue)) {
            
            if levelComplete == false {
        
                levelComplete = true;
                didWin = true;
                
                let winSound = SKAction.playSoundFileNamed("Video Game Win.mp3", waitForCompletion: true)
                runAction(winSound);
                
                if Level == 7 {
                    
                    alert.title = "CONGRATULATIONS"
                    alert.message = "You have completed Maniac Marbles, would you like to play again?"
                    alert.addButtonWithTitle("OK")
                    alert.addButtonWithTitle("No Thanks")
                    alert.show()
                    
                } else {
                    alert.title = "Level Complete!"
                    alert.message = "Would you like to play the next level?"
                    alert.addButtonWithTitle("OK")
                    alert.addButtonWithTitle("No Thanks")
                    alert.show()
                }
            }
        }
        
        // When Marbles Goes Out Of Bounds
        if ((bodyA.categoryBitMask == ColTypes.worldCategory.rawValue) && (bodyB.categoryBitMask == ColTypes.marbleCategory.rawValue) || (bodyB.categoryBitMask == ColTypes.worldCategory.rawValue) && (bodyA.categoryBitMask == ColTypes.marbleCategory.rawValue)) {
            
            if (levelComplete == false) {
                
                levelComplete = true;
                
                
                let failSound = SKAction.playSoundFileNamed("Game Over 2.mp3", waitForCompletion: true)
                runAction(failSound);
                alert.title = "Game Over!"
                alert.message = "Would you like to play again?"
                alert.addButtonWithTitle("OK")
                alert.addButtonWithTitle("No Thanks")
                alert.show()
                
            }
            
        };
    
    };
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let location = touches.anyObject().locationInNode(self);
        let touchedNode = self.nodeAtPoint(location);
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 1);
        var scene = LevelSelect(fileNamed: "LevelSelect");
        
        
        // check for node clicks
        if touchedNode.name != nil {
            
            if touchedNode.name == "backButton" {
                
                scene = LevelSelect(fileNamed: "LevelSelect");
                scene.scaleMode = SKSceneScaleMode.AspectFit
                self.scene!.view!.presentScene(scene, transition: transition)
            
            }
        }
    }

    override func update(currentTime: NSTimeInterval) {
        
    }

}
