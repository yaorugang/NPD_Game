//
//  BalloonGameViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 12/03/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit


class BalloonGameViewController: UIViewController
{
    @IBOutlet weak var MessageLabel: UILabel!
    
    var currentlevel: Int = 0;              // current game level, starts from 1.
    var balloonArray: [UIImageView] = [];   // the Int value for the dictionary type is used to store horizontal position of balloon.
    var timeSpan: Double = 0.0;                  // (seconds) time span between 2 consecutive balloons to fly
    var flyingDuration: Double = 0.0;            // (seconds) duration for balloon flying from bottom to top
    var balloonSize = CGSizeMake(50.0, 85.0)     // balloon size
    var balloonCountPerRow: UInt32 = 0              // maximum number of balloon that a single row can contain, which will be initialized in constructor.
    var bangImage = UIImage(named: "b_explode")
    var balloon_red = UIImage(named: "b_red")       // tag = 0
    var balloon_green = UIImage(named: "b_green")   // tag = 1
    var balloon_blue = UIImage(named: "b_blue")     // tag = 2
    var balloon_orange = UIImage(named: "b_orange") // tag = 3
    var balloon_pink = UIImage(named: "b_pink")     // tag = 4
    var balloon_yellow = UIImage(named: "b_yellow") // tag = 5
    var touchedBalloon: UIImageView?
    var counter = 0         // it will be used for counting the number of tapped balloons.
    var eligible_count = 0  // the number of successfully tapped balloons required to pass the game.
    var timer: NSTimer?
    var gameFinished: Bool = false      // whether game is finished (include gameover and pass)
    var prohibitedTag: Int = -1         // imageViews that have this tag value are prohibited to be tapped.
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set background image.
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "b_sky")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        // initialize the count of balloon that a single row can contain
        balloonCountPerRow = UInt32(UIScreen.mainScreen().bounds.width / balloonSize.width)
    }
    
    override func viewDidAppear(animated: Bool)
    {

    }
    
    func updateMessageLabel()
    {
        switch (prohibitedTag)
        {
        case 0:
            MessageLabel.text = "Do not touch the RED balloon"
        case 1:
            MessageLabel.text = "Do not touch the GREEN balloon"
        case 2:
            MessageLabel.text = "Do not touch the BLUE balloon"
        case 3:
            MessageLabel.text = "Do not touch the ORANGE balloon"
        case 4:
            MessageLabel.text = "Do not touch the PINK balloon"
        case 5:
            MessageLabel.text = "Do not touch the YELLOW balloon"
        default:
            MessageLabel.text = "";
        }
    }
    
    func startLevel1()
    {
        currentlevel = 1
        
        self.timeSpan = 3.0;        // 3 second
        self.flyingDuration = 10.0  // 10 seconds
        self.counter = 0            // initialize counter to be zero
        self.eligible_count = 5     // number of balloon required to be tapped
        self.prohibitedTag = -1     // -1 indicates none balloon to be prohibited
        self.gameFinished = false
        
        updateMessageLabel()
        
        var balloonList: [UIImage] = [self.balloon_red!]
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func startLevel2()
    {
        currentlevel = 2
        
        self.timeSpan = 2.0;
        self.flyingDuration = 8.0
        self.counter = 0
        self.eligible_count = 5
        self.gameFinished = false
        
        var balloonList = [balloon_red!, balloon_green!]
        
        // randomly choose a prohibited balloon.
        self.prohibitedTag = Int(arc4random_uniform(UInt32(balloonList.count)))
        
        updateMessageLabel()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func startLevel3()
    {
        currentlevel = 3
        
        self.timeSpan = 1.5;
        self.flyingDuration = 6.0
        self.counter = 0
        self.eligible_count = 5
        self.gameFinished = false
        
        var balloonList = [balloon_red!, balloon_green!, balloon_blue!]
        
        // randomly choose a prohibited balloon.
        self.prohibitedTag = Int(arc4random_uniform(UInt32(balloonList.count)))
        
        updateMessageLabel()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func startLevel4()
    {
        currentlevel = 4
        
        self.timeSpan = 1.0;
        self.flyingDuration = 6.0
        self.counter = 0
        self.eligible_count = 5
        self.gameFinished = false
        
        var balloonList = [balloon_red!, balloon_green!, balloon_blue!, balloon_orange!]
        
        // randomly choose a prohibited balloon.
        self.prohibitedTag = Int(arc4random_uniform(UInt32(balloonList.count)))
        
        updateMessageLabel()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func startLevel5()
    {
        currentlevel = 5
        
        self.timeSpan = 1.0;
        self.flyingDuration = 5.0
        self.counter = 0
        self.eligible_count = 5
        self.gameFinished = false
        
        var balloonList = [balloon_red!, balloon_green!, balloon_blue!, balloon_orange!, balloon_pink!]
        
        // randomly choose a prohibited balloon.
        self.prohibitedTag = Int(arc4random_uniform(UInt32(balloonList.count)))
        
        updateMessageLabel()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func startLevel6()
    {
        currentlevel = 6
        
        self.timeSpan = 1.0;
        self.flyingDuration = 4.0
        self.counter = 0
        self.eligible_count = 5
        self.gameFinished = false
        
        var balloonList = [balloon_red!, balloon_green!, balloon_blue!, balloon_orange!, balloon_pink!, balloon_yellow!]
        
        // randomly choose a prohibited balloon.
        self.prohibitedTag = Int(arc4random_uniform(UInt32(balloonList.count)))
        
        updateMessageLabel()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(self.timeSpan, target: self, selector: Selector("flayingBalloons:"), userInfo: balloonList, repeats: true)
    }
    
    func flayingBalloons(timer: NSTimer)
    {
        // get parameter
        var balloonList = timer.userInfo as! [UIImage]
        
        // initialize balloon image view
        var index = Int(arc4random_uniform(UInt32(balloonList.count)))                      // randomly pickup a balloon
        var imageView = UIImageView(image: balloonList[index], highlightedImage: bangImage) // it has a highlight version constructor
        imageView.tag = index                                                               // tag value is used to identify whether it's prohibited balloon
        imageView.userInteractionEnabled = true;
        
        // move balloon to start point
        var point_x = CGFloat(arc4random_uniform(balloonCountPerRow)) * balloonSize.width
        imageView.frame = CGRectMake(point_x, UIScreen.mainScreen().bounds.height, balloonSize.width, balloonSize.height)
        
        self.view.addSubview(imageView)
        balloonArray.append(imageView)
        
        // start animation
        var opt = UIViewAnimationOptions.CurveLinear | UIViewAnimationOptions.AllowUserInteraction
        UIView.animateWithDuration(self.flyingDuration, delay: 0, options: opt, animations:
        {
            imageView.frame.origin.y = 0
        }, completion:
            {
                (value: Bool) in
                if (value)  // 这里需要判断value的值，因为当动画自动执行结束后，value为true, 但是如果当动画执行过程中被手动停止，比如将imageview移除，value就为false。
                {
                    self.removeBalloon(imageView)
                    
                    if (!self.gameFinished && imageView.tag != self.prohibitedTag)
                    {
                        self.gameFinished = true
                        self.timer?.invalidate()
                    
                        var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                        self.presentViewController(popup, animated: false, completion: nil)
                        popup.showBalloonGameOver()
                    }
                }
            })
    }
    
    /*
     * Remove a single balloon from screen
     */
    func removeBalloon(balloon: UIImageView)
    {
        for (var index = 0; index < balloonArray.count; index++)
        {
            if (balloonArray[index] === balloon)
            {
                balloonArray.removeAtIndex(index)
                balloon.removeFromSuperview()
                
                break;
            }
        }
    }
    
    /* 
     * Clear all presented balloons 
     */
    func clearBalloon()
    {
        var count = balloonArray.count
        while (count > 0)
        {
            balloonArray.last?.removeFromSuperview()
            balloonArray.removeLast()
            
            count--
        }
    }
    
    /*
     * when touched down, use hitTest to find out which balloon is eventually tapped, if there is one tapped,
     * make it highlight.
     */
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        self.touchedBalloon = nil
        
        var touch: UITouch = touches.first as! UITouch;
        var touchPoint = touch.locationInView(self.view)
        
        for balloon in balloonArray
        {
            if ((balloon.layer.presentationLayer().hitTest(touchPoint)) != nil)
            {
                balloon.highlighted = true
                self.touchedBalloon = balloon
            }
        }

    }
    
    /*
     * when touched up, if there is a touched balloon, remove it from the view.
     */
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (touchedBalloon != nil)
        {
            if (touchedBalloon?.tag == self.prohibitedTag)
            {
                self.gameFinished = true    // have to set game to be finished status, otherwise, the residual balloons will incure 'gameover' view popupped up
                timer?.invalidate()
                
                var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                self.presentViewController(popup, animated: false, completion: nil)
                popup.showBalloonGameOver()
            }
            else
            {
                removeBalloon(touchedBalloon!)
            
                counter++
            
                if (counter >= eligible_count) // 点破一定数量的气球后就弹出next level view
                {
                    self.gameFinished = true    // have to set game to be finished status, otherwise, the residual balloons will incure 'gameover' view popupped up
                    timer?.invalidate()
                
                    var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                    self.presentViewController(popup, animated: false, completion: nil)
                    
                    if (currentlevel < 6)   // has more level to play.
                    {
                        popup.showBalloonGameNextLevel()
                    }
                    else                    // no more level to play.
                    {
                        popup.showBalloonGameWin()
                    }
                    
                    saveGameRecord()
                    
                    clearBalloon()  // clear all residual balloons that are still flying on the screen when the game is finished
                }
            }
        }
    }
    
    @IBAction func unwindBalloonGameQuit(segue: UIStoryboardSegue)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func unwindBalloonGameNextLevel(segue: UIStoryboardSegue)
    {
        switch (currentlevel)
        {
        case 1:
            startLevel2()
        case 2:
            startLevel3()
        case 3:
            startLevel4()
        case 4:
            startLevel5()
        case 5:
            startLevel6()
        default:
            break
        }
    }
    
    func saveGameRecord()
    {
        var gameInfo = GameInfo()
        gameInfo.pid = gGameUser.id
        gameInfo.gid = 3
        gameInfo.level = currentlevel
        gameInfo.time = 0
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

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 
     * Override the function to return true allowing to hide the status bar 
     */
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
