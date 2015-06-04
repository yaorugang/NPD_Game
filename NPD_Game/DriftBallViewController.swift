//
//  DriftBallViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 11/05/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit
import CoreMotion

class DriftBallViewController: UIViewController
{
    @IBOutlet weak var driftBall: UIImageView!
    @IBOutlet weak var circleBackground: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var moveTimer: NSTimer?     // used for updating movemnet of the ball
    var countingTimer: NSTimer? // used for updating remaining time on the screen
    var point_x: CGFloat?
    var point_y: CGFloat?
    var velocity: CGFloat?
    var timeLimit: Float = 20.0 // seconds
    var circleradius: CGFloat?
    var circlePath: CGMutablePathRef?
    let manager = CMMotionManager()
    var currentLevel = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        // set background color
//        self.view.backgroundColor = UIColor.blueColor()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        startGame(1)
    }
    
    func updateRemainingTime()
    {
        self.timeLabel.text = String(format: "Time remaining: %.1f seconds", timeLimit)
    }
    
    func countingDown()
    {
        timeLimit -= 0.1
        updateRemainingTime()
        
        if (timeLimit <= 0)
        {
            onGameover(true)
        }
    }
    
    /* reset background circle and the position of the ball */
    func reset()
    {
        var center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
        
        point_x = center.x
        point_y = center.y
        
        // create a logic circle
        circlePath = CGPathCreateMutable()
        CGPathAddArc(circlePath!, nil, center.x, center.y, circleradius!, 0, CGFloat(2 * M_PI), false)
        
        // resize circle background
        self.circleBackground.frame = CGRect(x: 0, y: 0, width: self.circleradius! * 2, height: self.circleradius! * 2)
        self.circleBackground.center = center
        
        // start accelerometer
        if (manager.accelerometerAvailable)
        {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdates()
            
            // start timers
            moveTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("onMove"), userInfo: nil, repeats: true)
            countingTimer  = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("countingDown"), userInfo: nil, repeats: true)
        }
        else
        {
            // give message to user that the accelerometer is not available
        }
    }
    
    func startGame(level: Int)
    {
        timeLimit = 20  // reset time
        
        self.currentLevel = level
        
        switch (currentLevel)
        {
        case 1:
            startLevel1()
        case 2:
            startLevel2()
        case 3:
            startLevel3()
        case 4:
            startLevel4()
        case 5:
            startLevel5()
        default:
            break
        }
    }
    
    func startLevel1()
    {
        self.velocity = 1.5
        self.circleradius = self.view.bounds.width * 0.4
        
        reset()
    }
    
    func startLevel2()
    {
        self.velocity = 2.0
        self.circleradius = self.view.bounds.width * 0.35
        
        reset()
    }
    
    func startLevel3()
    {
        self.velocity = 2.5
        self.circleradius = self.view.bounds.width * 0.3
        
        reset()
    }
    
    func startLevel4()
    {
        self.velocity = 3.0
        self.circleradius = self.view.bounds.width * 0.25
        
        reset()
    }
    
    func startLevel5()
    {
        self.velocity = 3.5
        self.circleradius = self.view.bounds.width * 0.2
        
        reset()
    }
    
    func onMove()
    {
        var data = manager.accelerometerData
        
        if (data != nil)
        {
            point_x! += CGFloat(data.acceleration.x) * self.velocity!
            point_y! -= CGFloat(data.acceleration.y) * self.velocity!
            
            driftBall.center.x = point_x!
            driftBall.center.y = point_y!
        }
        
        // whether the ball center is within the circle background
        if (!CGPathContainsPoint(circlePath, nil, driftBall.center, false))
        {
            onGameover(false)
        }
    }
    
    func onGameover(successed: Bool)
    {
        // stop timers
        moveTimer?.invalidate()
        countingTimer?.invalidate()
        
        // popup window
        if (successed)
        {
            var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
            self.presentViewController(popup, animated: false, completion: nil)
            
            if (self.currentLevel < 5)  // has more level to play
            {
                popup.showDriftGameNextLevel(20.0)
            }
            else                        // no more level to play
            {
                popup.showDriftGameWin()
            }
        }
        else
        {
            var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
            self.presentViewController(popup, animated: false, completion: nil)
            popup.showDriftGameOver(20 - timeLimit)
            
            saveGameRecord()
        }
    }
    
    func saveGameRecord()
    {
        var gameInfo = GameInfo()
        gameInfo.pid = gGameUser.id
        gameInfo.gid = 2
        gameInfo.level = currentLevel
        gameInfo.time = 20 - Int(timeLimit) + currentLevel * 20
        gameInfo.score = 0
        gameInfo.percent = 0
        gameInfo.accuracy = 0
        
        if (gGameDBAdapter.insertGameRecord(gameInfo))
        {
            println("insert succeed!")
        }
        else
        {
            println("insert failed!")
        }
    }
    
    
    @IBAction func unwindDriftGameReset(segue: UIStoryboardSegue)
    {
        startGame(1)
    }
    
    @IBAction func unwindDriftGameRetry(segue: UIStoryboardSegue)
    {
        startGame(currentLevel)
    }
    
    @IBAction func unwindDriftGameNextLevel(segue: UIStoryboardSegue)
    {
        if (self.currentLevel < 5)
        {
            startGame(currentLevel + 1)
        }
    }

    @IBAction func unwindDriftGameQuit(segue: UIStoryboardSegue)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }

    override func shouldAutorotate() -> Bool
    {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue) | Int(UIInterfaceOrientationMask.PortraitUpsideDown.rawValue)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
