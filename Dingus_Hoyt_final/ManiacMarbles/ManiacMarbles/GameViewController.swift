//
//  GameViewController.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/11/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        /* Pick a size for the scene */
        var scene = MainMenu(fileNamed:"MainMenu")
       
        // Configure the view.
        let skView = self.view as! SKView
        
        // error checking for scene
        if skView.scene == nil {
        
            //skView.showsFPS = true
            //skView.showsNodeCount = true
        
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
        
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
        
            skView.presentScene(scene)
            
        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
          return Int(UIInterfaceOrientationMask.LandscapeRight.rawValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
