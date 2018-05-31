//
//  GameScene.swift
//  Lec12
//
//  Created by hackeru on 17 Sivan 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var b: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        // z-order matters
        addBackground("backT")
        addBackground("frontT")
        addBackground("lights")
        addBackground("midt")
        addBall()
        addCircle()
        
        // add phisics:
        // caged ball
        cageTheBall()
        
       
        
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
        // this is basically the time counter
        if b != nil {
            
            if b.position.x < frame.width {
                b.position.x += 1
            }
            
        }
        
    }
    
    func addBackground(_ fileName: String) {
        let back = SKSpriteNode(imageNamed: fileName)
        back.size.width = self.size.width
        back.size.height = self.size.height
        back.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(back)
    }
    
    func addBall() {
        b = SKSpriteNode(imageNamed: "ball.png")
        let ballBody = SKPhysicsBody(circleOfRadius: b.size.width / 2)
        ballBody.friction = 0
        ballBody.allowsRotation = true // can spin?
        ballBody.restitution = 1
        ballBody.linearDamping = 0
        ballBody.angularDamping = 0
        
        b.position = CGPoint(x: frame.midX, y: frame.midY)
        
        
        b.physicsBody = ballBody
        addChild(b)
        
    }
    
    func addCircle() {
        let circle = SKSpriteNode(imageNamed: "circle.png")
        circle.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width / 2) // it will make him fall
        addChild(circle)
        
    }
    
    func cageTheBall()  {
        let fence = SKPhysicsBody(edgeLoopFrom: frame)
        fence.friction = 0
        fence.restitution = 1 // full elastic impact momentum conservation
        fence.isDynamic = false // we don't want the world to be influenced by any thing, fully static - defult is false
        self.physicsBody = fence
    
    }
    
}


