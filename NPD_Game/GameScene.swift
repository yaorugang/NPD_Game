//
//  GameScene.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 19/05/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    let BallCategoryName        = "ball"
    let PaddleCategoryName      = "paddle"
    let BlockCategoryName       = "block"
    let BlockNodeCategoryName   = "blockNode"
    
    let BallCategory:   UInt32  = 0x1 << 0  // 00000000000000000000000000000001
    let BottomCategory: UInt32  = 0x1 << 1  // 00000000000000000000000000000010
    let BlockCategory:  UInt32  = 0x1 << 2  // 00000000000000000000000000000100
    let PaddleCategory: UInt32  = 0x1 << 3  // 00000000000000000000000000001000
    
    var isStarted = false
    
    var ball: SKNode?
    var paddle: SKNode?
    var bottom: SKNode?
    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
        
        // create a physics body that borders the screen
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self    // set contact delegate to itself in order to process contact events.
        
        // retrive the ball object
        ball = childNodeWithName(BallCategoryName) as! SKSpriteNode
        
        // retrive the paddle object
        paddle = childNodeWithName(PaddleCategoryName) as! SKSpriteNode
        
        // create an edge-based body that covers the bottom of the screen
        let bottomRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1)
        bottom = SKNode()
        bottom!.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        addChild(bottom!)
        
        // set categoryBitMasks to objects
        paddle?.physicsBody!.categoryBitMask    = PaddleCategory
        ball?.physicsBody!.categoryBitMask      = BallCategory
        bottom?.physicsBody!.categoryBitMask    = BottomCategory
        
        // set contactTestBitMask. It will be notified when the ball makes contact with the bottom of the screen.
        ball?.physicsBody!.contactTestBitMask = BottomCategory
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // apply an impulse to the ball to start game
        if (!isStarted)
        {
            isStarted = true
            ball?.physicsBody!.applyImpulse(CGVectorMake(10, -10))
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        var touch = touches.first as! UITouch
        var touchLocation = touch.locationInNode(self)
        var previousLocation = touch.previousLocationInNode(self)
        
        var paddleX = paddle!.position.x + (touchLocation.x - previousLocation.x)
            
        paddleX = max(paddleX, paddle!.frame.width / 2)
        paddleX = min(paddleX, self.size.width - paddle!.frame.width / 2)
            
        paddle?.position = CGPointMake(paddleX, paddle!.position.y)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // react to the contact between ball and bottom
        if (firstBody.categoryBitMask == BallCategory && secondBody.categoryBitMask == BottomCategory)
        {
            println("hit bottom")
        }
    }
}
