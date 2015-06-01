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
    var mSpeed: CGFloat = 5.0
    var mPaddleLengthRate: CGFloat = 3.0
    var mCurrentLevel = -1
    
    var mPlayer = "test"
    var mScore = 0
    var mNext = 0
    var mHighestScore = 0
    var mLevel = 0
    var mLifeLeft = 0   // life left
    var mRank = 0

    
    override func didMoveToView(view: SKView)
    {
        super.didMoveToView(view)
        
        // create a physics body that borders the screen
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self    // set contact delegate to itself in order to process contact events.
        
        
        setLifeLeft(1)
        startLevel1()
    }
    
    func updateDashboard()
    {
        let player = self.view!.superview!.viewWithTag(1) as! UILabel
        let score = self.view!.superview!.viewWithTag(2) as! UILabel
        let next = self.view!.superview!.viewWithTag(3) as! UILabel
        let highestScore = self.view!.superview!.viewWithTag(4) as! UILabel
        let level = self.view!.superview!.viewWithTag(5) as! UILabel
        let live = self.view!.superview!.viewWithTag(6) as! UILabel
        let rank = self.view!.superview!.viewWithTag(7) as! UILabel
       
        player.text = mPlayer
        score.text  = "\(mScore)"
        next.text   = "\(mNext)"
        highestScore.text = "\(mHighestScore)"
        level.text  = "\(mLevel)"
        live.text   = "\(mLifeLeft)"
        rank.text   = "\(mRank)"
    }
    
    func getCurrentLevel() -> Int
    {
        return mCurrentLevel
    }
    
    func getLifeLeft() -> Int
    {
        return mLifeLeft
    }
    
    func setLifeLeft(live: Int)
    {
        mLifeLeft = live
    }
    
    func startLevel1()
    {
        mCurrentLevel = 1
        mPaddleLengthRate = 3
        mNext = 800
        mLevel = 1
        
        presentObjects()
        updateDashboard()
    }
    
    func startLevel2()
    {
        mCurrentLevel = 2
        mPaddleLengthRate = 2
        mNext = 1600
        mLevel = 2
        
        presentObjects()
        updateDashboard()
    }
    
    func presentObjects()
    {
        var span_x = CGRectGetWidth(self.frame) / 12.0
        var span_y = CGRectGetHeight(self.frame) / 40.0
        
        var blockWidth = span_x * 0.9
        var blockHeight = span_y * 0.9
    
        // create blocks
        for i in 1...10
        {
            for j in 0...7
            {
                let block = SKSpriteNode(imageNamed: "block.png")
                block.size = CGSizeMake(blockWidth, blockHeight)
                
                // Set position of a block. The position propert indicates the center of the block.
                // That's why (+0.5)
                let x = (CGFloat(i) + 0.5) * span_x
                let y = CGRectGetHeight(self.frame) - (CGFloat(j) + 0.5) * span_y
                block.position = CGPointMake(x, y)
                
                block.physicsBody = SKPhysicsBody(rectangleOfSize: block.frame.size)
                block.physicsBody!.allowsRotation = false
                block.physicsBody!.friction = 0.0
                block.physicsBody!.affectedByGravity = false
                block.physicsBody!.restitution = 1.0
                block.physicsBody!.dynamic = false
                block.name = BlockCategoryName
                block.physicsBody!.categoryBitMask = BlockCategory
                addChild(block)
            }
        }
        
        // create paddle
        let paddle = SKSpriteNode(color: UIColor.whiteColor(), size: CGSizeMake(blockWidth * mPaddleLengthRate, blockHeight))
        paddle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.frame) / 20.0)
        paddle.physicsBody = SKPhysicsBody(rectangleOfSize: paddle.frame.size)
        paddle.physicsBody!.allowsRotation = false
        paddle.physicsBody!.friction = 0.0
        paddle.physicsBody!.restitution = 1.0
        paddle.physicsBody!.affectedByGravity = false
        paddle.physicsBody!.dynamic = false
        paddle.name = PaddleCategoryName
        paddle.physicsBody!.categoryBitMask = PaddleCategory
        addChild(paddle)
        
        // create ball
        let ball = SKSpriteNode(imageNamed: "Ball.png")
        ball.size = CGSizeMake(span_y, span_y)
        ball.position = CGPointMake(paddle.position.x, paddle.position.y + ball.size.height)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: span_y * 0.5)
        ball.physicsBody!.allowsRotation = false
        ball.physicsBody!.friction = 0.0
        ball.physicsBody!.restitution = 1.0
        ball.physicsBody!.affectedByGravity = false
        ball.physicsBody!.linearDamping = 0.0
        ball.physicsBody!.angularDamping = 0.0
        ball.physicsBody!.dynamic = true
        ball.name = BallCategoryName
        ball.physicsBody!.categoryBitMask = BallCategory
        ball.physicsBody!.contactTestBitMask = BottomCategory | BlockCategory
        addChild(ball)
        
        // create an edge-based body that covers the bottom of the screen
        let bottomRect = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 1)
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFromRect: bottomRect)
        bottom.physicsBody!.categoryBitMask = BottomCategory
        addChild(bottom)
        
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if let ball = childNodeWithName(BallCategoryName) as? SKSpriteNode
        {
            // apply an impulse to the ball to start game
            if (!isStarted)
            {
                isStarted = true
                ball.physicsBody!.applyImpulse(CGVectorMake(mSpeed, -mSpeed))
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (isStarted)
        {
            let paddle = childNodeWithName(PaddleCategoryName) as! SKSpriteNode
            
            var touch = touches.first as! UITouch
            var touchLocation = touch.locationInNode(self)
            var previousLocation = touch.previousLocationInNode(self)
            
            var paddleX = paddle.position.x + (touchLocation.x - previousLocation.x)
            
            paddleX = max(paddleX, paddle.frame.width / 2)
            paddleX = min(paddleX, self.size.width - paddle.frame.width / 2)
            
            paddle.position = CGPointMake(paddleX, paddle.position.y)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        
    }
    
    override func update(currentTime: CFTimeInterval)
    {
        if (isStarted)
        {
            let ball = childNodeWithName(BallCategoryName) as! SKSpriteNode
            
            // control bouncing direction
            if (ball.physicsBody!.velocity.dx == 0)
            {
                ball.physicsBody!.applyImpulse(CGVectorMake(mSpeed, 0))
            }
            
            if (ball.physicsBody!.velocity.dy == 0)
            {
                ball.physicsBody!.applyImpulse(CGVectorMake(0, -mSpeed))
            }
            
            // control speed
            let maxSpeed: CGFloat = 550.0
            let speed = sqrt(ball.physicsBody!.velocity.dx * ball.physicsBody!.velocity.dx + ball.physicsBody!.velocity.dy * ball.physicsBody!.velocity.dy)
            
            if speed > maxSpeed
            {
                ball.physicsBody!.linearDamping = 0.4
            }
            else
            {
                ball.physicsBody!.linearDamping = 0.0
            }
        }
    }
    
    func stopGame()
    {
        self.removeAllChildren()
        self.isStarted = false
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
            stopGame()
            
            if (mLifeLeft > 0)  // has more life to play
            {
                showRetryView()
            }
            else                // no more life
            {
                showGameOverView()
            }
        }
        // react to the contact between ball and blocks
        else if (firstBody.categoryBitMask == BallCategory && secondBody.categoryBitMask == BlockCategory)
        {
            secondBody.node!.removeFromParent()
            mScore += 10
            
            if (mScore > mHighestScore)
            {
                mHighestScore = mScore
            }
            
            updateDashboard()
            
            if (mScore >= mNext)
            {
                stopGame()
                
                if (mCurrentLevel >= 2)
                {
                    showGameWinView()   // win the game
                }
                else
                {
                    showNextLevelView() // go to next level
                }
                
            }
        }
    }
    
    func showRetryView()
    {
        let retryButton = self.view!.superview!.viewWithTag(8) as! UIButton
        retryButton.hidden = false
        
        let quitButton = self.view!.superview!.viewWithTag(10) as! UIButton
        quitButton.hidden = false
    }
    
    func showNextLevelView()
    {
        let nextLevelButton = self.view!.superview!.viewWithTag(9) as! UIButton
        nextLevelButton.hidden = false
        
        let quitButton = self.view!.superview!.viewWithTag(10) as! UIButton
        quitButton.hidden = false
    }
    
    func showGameWinView()
    {
        let quitButton = self.view!.superview!.viewWithTag(10) as! UIButton
        quitButton.hidden = false
    }
    
    func showGameOverView()
    {
        let quitButton = self.view!.superview!.viewWithTag(10) as! UIButton
        quitButton.hidden = false
    }
}
