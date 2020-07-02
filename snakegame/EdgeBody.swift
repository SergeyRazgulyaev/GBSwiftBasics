//
//  EdgeBody.swift
//  snakegame
//
//  Created by Sergey Razgulyaev on 25.06.2020.
//  Copyright © 2020 nrodionov. All rights reserved.
//

import SpriteKit

class EdgeBody: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        physicsBody?.contactTestBitMask = CollisionCategories.Snake
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
