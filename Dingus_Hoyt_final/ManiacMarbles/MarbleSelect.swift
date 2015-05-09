//
//  MarbleSelect.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/23/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import Foundation
import SpriteKit


class MarbleSelect: SKScene {
    
    
    override func didMoveToView(view: SKView) {
        
        let blueMarb  = childNodeWithName("blue");
        let redMarb   = childNodeWithName("red");
        let greenMarb = childNodeWithName("green");
        
    }
    
    // touch handling
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let location = touches.anyObject()!.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 1)
        var scene = LevelSelect(fileNamed: "LevelSelect");
        
        
        // check for node clicks
        if touchedNode.name != nil {
            
            if touchedNode.name == "blue" {
                
                NSUserDefaults.standardUserDefaults().setObject("blueMarble", forKey: "marble")
                scene = LevelSelect(fileNamed: "LevelSelect");
                scene.scaleMode = SKSceneScaleMode.AspectFit
                self.scene.view.presentScene(scene, transition: transition)
                
                
            } else if touchedNode.name == "red" {
                    
                NSUserDefaults.standardUserDefaults().setObject("redMarble", forKey: "marble")
                scene = LevelSelect(fileNamed: "LevelSelect");
                scene.scaleMode = SKSceneScaleMode.AspectFit
                self.scene.view.presentScene(scene, transition: transition)
                
            } else if touchedNode.name == "green" {
                    
                NSUserDefaults.standardUserDefaults().setObject("greenMarble", forKey: "marble")
                scene = LevelSelect(fileNamed: "LevelSelect");
                scene.scaleMode = SKSceneScaleMode.AspectFit
                self.scene.view.presentScene(scene, transition: transition)
                
            }
        }
            
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
    
}
