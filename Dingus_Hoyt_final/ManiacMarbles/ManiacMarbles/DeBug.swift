//
//  DeBug.swift
//  ManiacMarbles
//
//  Created by Hoyt Dingus on 9/20/14.
//  Copyright (c) 2014 Hoyt Dingus. All rights reserved.
//

import Foundation
import SpriteKit

let kDebugDraw = true

extension SKNode {
    
    func attachDegbugFrameFromPath(bodyPath: CGPathRef) {
        
        if kDebugDraw == false {
            
            return
            
        }
        
        let shape = SKShapeNode();
        
        shape.path = bodyPath;
        shape.fillColor = SKColor(red: 1.0, green: 0, blue: 0, alpha: 0.25);
        shape.lineWidth = 1;
        shape.strokeColor = SKColor(red: 1.0, green: 0, blue: 0, alpha: 1.0);
        shape.zPosition = 1;
        self.addChild(shape);
        
    }
    
    func attachDebugRectWithSize(Size: CGSize) {
        
        
        let bodyPath = CGPathCreateWithRect(CGRectMake(-Size.width/2, -Size.height/2, Size.width, Size.height), nil);
        
        attachDegbugFrameFromPath(bodyPath);
        
    }
    
}