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
        
        
        
        playWithAction()
        
        
        // caged ball
        cageTheBall()
        
       addNinjas()
        addPaddle()
        
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
    
    var isFingerOnPaddele = false {
        // property observer !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        didSet{
            print(isFingerOnPaddele)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // when the user touches the view
        let p = touches.first!.location(in: self)
        let paddle = childNode(withName: "paddle")!
        
        isFingerOnPaddele = paddle.frame.contains(p)
       
        //
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let p = touches.first!.location(in: self)
        let paddle = childNode(withName: "paddle")!
        
        if isFingerOnPaddele {
            paddle.position.x = p.x
            
        }
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        /*
        // each time the next frame is presented
        // this is basically the time counter
        if b != nil {
            
            if b.position.x < frame.width {
                b.position.x += 1
            }
            
        }
        */
        
        
        
        
    }
    
    func addBackground(_ fileName: String) {
        let back1 = SKSpriteNode(imageNamed: fileName)
        back1.size.width = self.size.width
        back1.size.height = self.size.height
        back1.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let back2 = SKSpriteNode(imageNamed: fileName)
        back2.size.width = self.size.width
        back2.size.height = self.size.height
        back2.position = CGPoint(x: frame.midX + size.width, y: frame.midY)
        
        addChild(back1)
        addChild(back2)
        
        playWithActionMoveBackground(t: back1)
        playWithActionMoveBackground(t: back2)
        //
        
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
        
        // hit the ball
        ballBody.applyImpulse(CGVector(dx: 100, dy: 100))
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
        physicsWorld.gravity = CGVector.zero
        
        self.physicsBody = fence
    
    }
    
    func playWithAction() {
        // actions are basically animations
        
        let r = arc4random_uniform(UInt32(frame.width))
        let t = SKSpriteNode (imageNamed: "pig")
        t.position = CGPoint(x: CGFloat(r), y: frame.midY)
        
        let rotate = SKAction.rotate(byAngle: .pi/4, duration: 10)
    
        addChild(t)
        
        
        /* ugly nesting
        t.run(rotate) {
            // do this after complition
            t.run(SKAction.fadeOut(withDuration: 2)) {
                // after fade out , kill the pig - not just make it invisiable
                t.run(SKAction.removeFromParent())
            }
        }
        */
        
        // beutifull sequence
        let rot = SKAction.rotate(byAngle: .pi/4, duration: 10)
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        let byeBye = SKAction.removeFromParent()
        let sequence = SKAction.sequence([rot, fadeOut, byeBye])
        t.run(sequence)
        
        
    }
    
    func playWithActionMoveBackground(t: SKSpriteNode) {
       
        
        // beutifull sequence
        
        let vector = CGVector(dx: size.width * -1, dy: 0)
        let opesiteVector = CGVector(dx: size.width, dy: 0)
        let move = SKAction.move(by: vector, duration: 5)
        let goBack = SKAction.move(by: opesiteVector, duration: 0)
        
        let sequence = SKAction.sequence([move, goBack])
        let magic = SKAction.repeatForever(sequence)
        t.run(magic)
        
        
    }
    
    func addNinjas() {
        let numNinjas: CGFloat = 8
        
        let ninja = SKSpriteNode(imageNamed: "ninja")
        let nw = ninja.frame.width
        let pad = (size.width - numNinjas * nw) * 0.5
        
        for i in 0..<Int(numNinjas) {
            let nin = SKSpriteNode(imageNamed: "ninja")
            nin.position.x = pad + CGFloat(i) * nw
            nin.position.y = frame.height - nw
            addChild(nin)
            
        }
        
        
        
        
        //
    }
    
    func addPaddle() {
        let paddle = SKSpriteNode(imageNamed: "block")
        paddle.position = CGPoint(x: frame.midX, y: 0 + 65)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.allowsRotation = false
        
        paddle.name = "paddle" // by giving a node a name we can allaways locate it, without the need to write it in the class level (property)
        addChild(paddle)
    }
    
    
}


