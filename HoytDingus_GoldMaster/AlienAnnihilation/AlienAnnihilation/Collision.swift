//
//  Collision.swift
//  AlienAnnihilation
//
//  Created by Hoyt Dingus on 3/7/15.
//  Copyright (c) 2015 Hoyt Dingus. All rights reserved.
//

import Foundation;
import SpriteKit;

protocol Collision {
    
    func handleCollisionWithObject(otherBody: SKPhysicsBody);
    
}
