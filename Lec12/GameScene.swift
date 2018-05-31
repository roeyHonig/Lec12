//
//  GameScene.swift
//  Lec12
//
//  Created by hackeru on 17 Sivan 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        /*Setup the game scene here*/
        
        // in games there are nodes, node are everything, like charcters or anything
        
        // 1). init sk Label node
        let label = SKLabelNode(fontNamed: "Chalkduster")
        // 2). set text and other properties
        label.text = "Hello, World!"
        label.fontSize = 40
        // 3). position the node
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        
        // 4). add the node
        addChild(label) //
    }
    
    fileprivate func positionLabel(_ location: CGPoint, _ label: SKLabelNode) {
        // location is of type CGPoint
        
        // 1). init sk Label node
        
        // 2). set text and other properties
        label.text = "Hello, World!"
        label.fontSize = 40
        // 3). position the node
        label.position = CGPoint(x: location.x, y: location.y)
        
        // 4). add the node
        addChild(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when the user touches the view
        // call a method to add the label
        for touch in touches {
            let label = SKLabelNode(fontNamed: "Chalkduster")
            let location = touch.location(in: self)
            positionLabel(location, label) //
            
        }
        
        
       
        //
    }
    
    override func update(_ currentTime: TimeInterval) {
        // each time the next frame is presented
    }
    
    
}


