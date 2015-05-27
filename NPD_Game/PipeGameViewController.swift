//
//  PipeGameViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 8/02/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class PipeGameViewController: UIViewController
{
    var path_level1: CGMutablePathRef = CGPathCreateMutable()
    var path_level2: CGMutablePathRef = CGPathCreateMutable()
    var path_level3: CGMutablePathRef = CGPathCreateMutable()
    
    @IBOutlet weak var mFingerPoint: UIImageView!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    
    var mValidFinger: Bool = false  // used for identifing whether pressed position is valid
    var mStartPoint: CGPoint?
    var mStartFrame: CGRect?
    var mTimeInterval = NSTimeInterval()    // recording start time
    var timer = NSTimer()           // used for time counting
    var currentLevel = 1
    var currentPath: CGMutablePathRef?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        
        initPath()
        
        
        switchToLevel(1)
    }
    
    func startTimer()
    {
        mTimeInterval = NSDate.timeIntervalSinceReferenceDate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    func stopTimer()
    {
        timer.invalidate()
    }
    
    func updateTime()
    {
        var timeInterval = Int(NSDate.timeIntervalSinceReferenceDate() - mTimeInterval)
        
        var second = timeInterval % 60
        var minutes = timeInterval / 60
        var hour = 0
        
        if (minutes > 59)
        {
            hour = minutes / 60
            minutes = minutes % 60
        }
       
        textView.text = String(format: "Time: %02d:%02d:%02d", hour, minutes, second)
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
    

    // initialize paths for all levels
    func initPath()
    {
        var size = self.view.bounds.size
        var ratio_x = size.width / 640
        var ratio_y = size.height / 975
        
        // initialize the level 1 path
        CGPathMoveToPoint(path_level1, nil, 639 * ratio_x, 860 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 116 * ratio_x, 853 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 105 * ratio_x, 817 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 105 * ratio_x, 328 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 210 * ratio_x, 328 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 210 * ratio_x, 751 * ratio_y)
        CGPathAddLineToPoint(path_level1, nil, 639 * ratio_x, 751 * ratio_y)
        CGPathCloseSubpath(path_level1)
        
        // initialize the leve 2 path
        CGPathMoveToPoint(path_level2, nil, 0, 750 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 208 * ratio_x, 750 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 208 * ratio_x, 435 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 536 * ratio_x, 435 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 536 * ratio_x, 537 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 639 * ratio_x, 537 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 639 * ratio_x, 647 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 426 * ratio_x, 645 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 420 * ratio_x, 543 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 322 * ratio_x, 539 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 322 * ratio_x, 852 * ratio_y)
        CGPathAddLineToPoint(path_level2, nil, 0, 852 * ratio_y)
        CGPathCloseSubpath(path_level2)
        
        // initialize the level 3 path
        CGPathMoveToPoint(path_level3, nil, 0, 427 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 204 * ratio_x, 429 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 204 * ratio_x, 641 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 320 * ratio_x, 643 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 322 * ratio_x, 747 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 422 * ratio_x, 747 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 424 * ratio_x, 643 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 532 * ratio_x, 643 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 532 * ratio_x, 543 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 312 * ratio_x, 537 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 310 * ratio_x, 333 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 426 * ratio_x, 333 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 424 * ratio_x, 431 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 632 * ratio_x, 429 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 632 * ratio_x, 751 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 540 * ratio_x, 751 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 540 * ratio_x, 859 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 206 * ratio_x, 859 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 206 * ratio_x, 753 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 100 * ratio_x, 749 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 96 * ratio_x, 541 * ratio_y)
        CGPathAddLineToPoint(path_level3, nil, 0, 541 * ratio_y)
        CGPathCloseSubpath(path_level3)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        
        var touch: UITouch = touches.first as! UITouch
        
        mStartPoint = touch.locationInView(self.view)   // record start touched point
        mStartFrame = mFingerPoint.frame                // record position of the icon
        
        // validate whether the touched point is within the frame of the icon, if yes, set touch to be valid, otherwise invalid
        if (touch.view === mFingerPoint)
        {
            self.mValidFinger = true
        }
        else
        {
            self.mValidFinger = false;
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        // if touch is valid, moving the icon along the touch point's trajectory
        if (mValidFinger)
        {
            var touch: UITouch = touches.first as! UITouch;
            var currentPoint = touch.locationInView(self.view)
            var frame: CGRect = mStartFrame!
            frame.origin.x = mStartFrame!.origin.x + (currentPoint.x - mStartPoint!.x)
            frame.origin.y = mStartFrame!.origin.y + (currentPoint.y - mStartPoint!.y)
            mFingerPoint.frame = frame
            
            // in the circusmestance when the icon moving outside the valid range, evaluate that if should jump to
            // the next level or finishe the game
            if (!withinValidRange())
            {
                stopTimer()
                
                if (isGoingOut())
                {
                    if (currentLevel < 3) // show next level view
                    {
                        
                        var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                        self.presentViewController(popup, animated: false, completion: nil)
                        popup.showPipeGameNextLevel()
                    }
                    else // show win view
                    {
                        var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                        self.presentViewController(popup, animated: false, completion: nil)
                        popup.showPipeGameWin()
                    }
                    
                }
                else
                {
                    // show game over view
                    var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController
                    self.presentViewController(popup, animated: false, completion: nil)
                    popup.showPipeGameOver()
                }
                
                mValidFinger = false
            }
        }
    }
    
    // evaluate whether the entire icon is within the range of path, compute 4 points of the icon
    func withinValidRange() -> Bool
    {
        var frame = mFingerPoint.frame
        
        var leftTop = frame.origin
        
        var leftBottom = CGPoint()
        leftBottom.x = frame.origin.x
        leftBottom.y = frame.origin.y + frame.height
        
        var rightTop = CGPoint()
        rightTop.x = frame.origin.x + frame.width
        rightTop.y = frame.origin.y
        
        var rightBottom = CGPoint()
        rightBottom.x = frame.origin.x + frame.width
        rightBottom.y = frame.origin.y + frame.height
        
        if  CGPathContainsPoint(currentPath, nil, leftTop, false) &&
            CGPathContainsPoint(currentPath, nil, leftBottom, false) &&
            CGPathContainsPoint(currentPath, nil, rightTop, false) &&
            CGPathContainsPoint(currentPath, nil, rightBottom, false)
        {
            return true
        }
        
        return false
    }
    
    // evalue whether the icon exited from the designated port
    func isGoingOut() -> Bool
    {
        switch currentLevel
        {
        case 1:
            var point_x = mFingerPoint.frame.origin.x + mFingerPoint.frame.width
            if (point_x >= self.view.bounds.size.width - 5)
            {
                return true
            }
            else
            {
                return false;
            }
        case 2:
            var point_x = mFingerPoint.frame.origin.x + mFingerPoint.frame.width
            if (point_x >= self.view.bounds.size.width - 5)
            {
                return true
            }
            else
            {
                return false;
            }
        case 3:
            var point_x = mFingerPoint.frame.origin.x
            if (point_x <= 5)
            {
                return true
            }
            else
            {
                return false;
            }
        default:
            return false
            
        }
    }
    
    func switchToLevel(level: Int)
    {
        currentLevel = level
        
        var size = self.view.bounds.size
        var ratio_x = size.width / 640
        var ratio_y = size.height / 975
        var frame = mFingerPoint.frame
        
        
        switch (level)
        {
        case 1:
            currentPath = path_level1
            
            frame.origin.x = 114 * ratio_x
            frame.origin.y = 339 * ratio_y
            mFingerPoint.frame = frame
            
            backgroundImg.image = UIImage(named: "pipegame_level1")
            
        case 2:
            currentPath = path_level2
            
            frame.origin.x = 12 * ratio_x
            frame.origin.y = 773 * ratio_y
            mFingerPoint.frame = frame
            
            backgroundImg.image = UIImage(named: "pipegame_level2")
            
        case 3:
            currentPath = path_level3
            
            frame.origin.x = 322 * ratio_x
            frame.origin.y = 333 * ratio_y
            mFingerPoint.frame = frame
            
            backgroundImg.image = UIImage(named: "pipegame_level3")
            
        default:
            currentPath = nil
        }
        
        textView.text = "Time: 00:00:00"
        startTimer()
    }
    
    @IBAction func unwindPipeGameQuit(segue: UIStoryboardSegue)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func unwindPipeGameNextLevel(segue: UIStoryboardSegue)
    {
        if (currentLevel < 3)
        {
            switchToLevel(currentLevel + 1)
        }
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
