//
//  LevelSelect.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/13/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class LevelSelect: SKScene {
    
    
    
    override func didMoveToView(view: SKView) {
        
        // level thumbnails
        let level1Thumb = childNodeWithName("level1Thumb")
        let level2Thumb = childNodeWithName("level2Thumb");
        let level3Thumb = childNodeWithName("level3Thumb");
        let level4Thumb = childNodeWithName("level4Thumb");
        let level5Thumb = childNodeWithName("level5Thumb");
        let level6Thumb = childNodeWithName("level6Thumb");
        let level7Thumb = childNodeWithName("level 7 thumb");
       
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
         
        let location = touches.anyObject().locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 1)
        var scene = GameScene(fileNamed: "gameScene 1");
        
        // level node selection handling
        if touchedNode.name != nil {
           
            
            if touchedNode.name == "level1Thumb" {
                
                NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 1");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            } else if touchedNode.name == "level2Thumb" {
                
                NSUserDefaults.standardUserDefaults().setInteger(2, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 2");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            } else if touchedNode.name == "level3Thumb" {
                
                NSUserDefaults.standardUserDefaults().setInteger(3, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 3");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
       
            }else if touchedNode.name == "level4Thumb" {
                
                NSUserDefaults.standardUserDefaults().setInteger(4, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 4");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            }else if touchedNode.name == "level5Thumb" {
            
                NSUserDefaults.standardUserDefaults().setInteger(5, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 5");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            }else if touchedNode.name == "level6Thumb" {
            
                NSUserDefaults.standardUserDefaults().setInteger(6, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 6");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            }else if touchedNode.name == "level 7 thumb" {
            
                NSUserDefaults.standardUserDefaults().setInteger(7, forKey: "level")
                NSUserDefaults.standardUserDefaults().synchronize()
                scene = GameScene(fileNamed: "gameScene 7");
                scene.scaleMode = SKSceneScaleMode.AspectFit
            
                self.scene.view.presentScene(scene, transition: transition)
        
            }
            
        }
        
    }
    
    
}
