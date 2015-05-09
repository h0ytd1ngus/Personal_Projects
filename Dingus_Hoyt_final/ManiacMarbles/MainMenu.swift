//
//  MainMenu.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/13/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu: SKScene {
    
    
    let playmusic = SKAction.playSoundFileNamed("8-Bit Theme.wav", waitForCompletion: true);
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = SKColor.blackColor()
        self.runAction(SKAction.repeatActionForever(playmusic));
        
        // Sprite Creation
        let myLabel = SKLabelNode(fontNamed:"Helvetica Neue Condensed Black")
            myLabel.text = "Maniac Marbles";
            myLabel.fontSize = 50;
            myLabel.fontColor = SKColor.whiteColor()
            myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)/0.75);
            myLabel.zPosition = 0.1;
        
        var start = SKLabelNode (fontNamed: "Helvetica Neue Condensed Black")
            start.text = "| Tap Screen to Begin |"
            start.fontSize = 36;
            start.fontColor = SKColor.grayColor()
            start.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)/1.7);
        
        var changeMarble = SKLabelNode (fontNamed: "Helvetica Neue Condensed Black")
            changeMarble.name = "MarbleSelect"
            changeMarble.text = "Choose Marble"
            changeMarble.fontSize = 36;
            changeMarble.fontColor = SKColor.whiteColor()
            changeMarble.position = CGPoint(x:CGRectGetMidX(self.frame)*1.75, y:CGRectGetMidY(self.frame)*1.65);
        
        let sprite = SKSpriteNode(imageNamed:"marbleMain")
            sprite.name = "sprite"
            sprite.xScale = 0.20
            sprite.yScale = 0.20
            sprite.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        let spin = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(spin))
        
        // Add Sprites to Scene
        self.addChild(myLabel);
        self.addChild(start);
        self.addChild(changeMarble);
        self.addChild(sprite);
        
    }
    
    // touch handling
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 1)
        var scene = LevelSelect(fileNamed: "LevelSelect");
            scene.scaleMode = .AspectFit
        
        let location = touches.anyObject().locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        // check for node clicks
            
        if touchedNode.name == nil {
            
            self.scene.view.presentScene(scene, transition: transition)
        
        } else {
            
            var scene2 = MarbleSelect(fileNamed: "MarbleSelect");
            scene2.scaleMode = SKSceneScaleMode.AspectFit
            self.scene.view.presentScene(scene2, transition: transition)
            
        }

    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    
        
    }

}
