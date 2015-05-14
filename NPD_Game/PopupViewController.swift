//
//  CompleteViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 3/03/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController
{
    
    @IBOutlet weak var mCorner_btn: UIButton!
    @IBOutlet weak var mCenter_btn: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWinMode()
    {
        mCorner_btn.hidden = true
        mCenter_btn.setBackgroundImage(UIImage(named: "win"), forState: .Normal)
        mCenter_btn.addTarget(self, action: "performSegueQuit:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showNextLevelMode()
    {
        mCorner_btn.addTarget(self, action: "performSegueQuit:", forControlEvents: UIControlEvents.TouchUpInside)
        mCenter_btn.addTarget(self, action: "performSegueNextLevel:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showBalloonNextLevel()
    {
        mCorner_btn.hidden = true
        
        mCenter_btn.setBackgroundImage(UIImage(named: "b_nextlevel"), forState: .Normal)
        
        var width = self.view.bounds.width
        var height = self.view.bounds.height
        mCenter_btn.frame = CGRect(x: 0.0, y: height * 0.4, width: width, height: height / 4)
        
        mCenter_btn.addTarget(self, action: "performSegueBalloonNextLevel:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showBalloonGameover()
    {
        mCorner_btn.hidden = true;
        
        mCenter_btn.setBackgroundImage(UIImage(named: "b_gameover"), forState: .Normal)
        mCenter_btn.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        mCenter_btn.addTarget(self, action: "performSegueQuitBalloon:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPokerReset()
    {
        mCorner_btn.hidden = true;
        
        mCenter_btn.setBackgroundImage(UIImage(named: "reset"), forState: .Normal)
        
        var width = self.view.bounds.width / 3
        mCenter_btn.frame = CGRect(x: 0.0, y: 0.0, width: width, height: width)
        mCenter_btn.center.x = self.view.bounds.width / 2
        mCenter_btn.center.y = self.view.bounds.height / 2
        
        mCenter_btn.addTarget(self, action: "performSegueResetPokerGame:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPokerNextLevel()
    {
        mCorner_btn.hidden = true;
        
        mCenter_btn.setBackgroundImage(UIImage(named: "next"), forState: .Normal)
        
        var width = self.view.bounds.width / 3
        mCenter_btn.frame = CGRect(x: 0.0, y: 0.0, width: width, height: width)
        mCenter_btn.center.x = self.view.bounds.width / 2
        mCenter_btn.center.y = self.view.bounds.height / 2
        
        mCenter_btn.addTarget(self, action: "performSeguePokerNextLevel:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showColorGameOver(var score: Int)
    {
        mCorner_btn.hidden = true;
        self.view.backgroundColor = UIColor.whiteColor()
        
        var label = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height / 2))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Congratulations! Your score is \(score)"
        self.view.addSubview(label)
        
        mCenter_btn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        var width = self.view.bounds.width / 2
        mCenter_btn.frame = CGRect(x: 0.0, y: 0.0, width: width, height: width / 5)
        mCenter_btn.center.x = self.view.bounds.width / 2
        mCenter_btn.center.y = self.view.bounds.height * 0.7
        mCenter_btn.setTitle("Quit", forState: .Normal)
        mCenter_btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        mCenter_btn.addTarget(self, action: "performSegueQuitColorGame:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showDriftBallOver(var score: CGFloat)
    {
        mCorner_btn.hidden = true;
        mCenter_btn.hidden = true;
        self.view.backgroundColor = UIColor.whiteColor()
        
        var label = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height / 2))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Your score is \(score) seconds"
        self.view.addSubview(label)

        var retryBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        retryBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.6)
        retryBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        retryBtn.setTitle("Retry", forState: .Normal)
        retryBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        retryBtn.addTarget(self, action: "performSegueRetryDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(retryBtn)
        
        var resetBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        resetBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.7)
        resetBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        resetBtn.setTitle("Reset", forState: .Normal)
        resetBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        resetBtn.addTarget(self, action: "performSegueResetDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(resetBtn)
        
        var quitBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        quitBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.8)
        quitBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        quitBtn.setTitle("Quit", forState: .Normal)
        quitBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        quitBtn.addTarget(self, action: "performSegueQuitDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(quitBtn)
    }
    
    func showDriftBallNext(var score: CGFloat)
    {
        mCorner_btn.hidden = true;
        mCenter_btn.hidden = true;
        self.view.backgroundColor = UIColor.whiteColor()
        
        var label = UILabel(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height / 2))
        label.textAlignment = NSTextAlignment.Center
        label.text = "Your score is \(score) seconds"
        self.view.addSubview(label)
        
        var retryBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        retryBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.6)
        retryBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        retryBtn.setTitle("Retry", forState: .Normal)
        retryBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        retryBtn.addTarget(self, action: "performSegueRetryDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(retryBtn)
        
        var nextBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        nextBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.7)
        nextBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        nextBtn.setTitle("Next Level", forState: .Normal)
        nextBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        nextBtn.addTarget(self, action: "performSegueNextDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBtn)
        
        var quitBtn = UIButton(frame: CGRectMake(0, 0, self.view.bounds.width * 0.6, self.view.bounds.height * 0.08))
        quitBtn.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height * 0.8)
        quitBtn.setBackgroundImage(UIImage(named: "buttonbg"), forState: .Normal)
        quitBtn.setTitle("Quit", forState: .Normal)
        quitBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        quitBtn.addTarget(self, action: "performSegueQuitDriftBall:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(quitBtn)
    }
    
    func performSegueNextLevel(sender: UIButton!)
    {
        performSegueWithIdentifier("popupUnwindToNextLevel", sender: sender)
    }
    
    func performSegueQuit(sender: UIButton!)
    {
        performSegueWithIdentifier("popupUnwindToQuit", sender: sender)
    }
    
    func performSegueBalloonNextLevel(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToBalloonNextLevel", sender: sender)
    }
    
    func performSegueQuitBalloon(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToQuitBalloon", sender: sender)
    }
    
    func performSegueResetPokerGame(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToResetPoker", sender: sender)
    }
    
    func performSeguePokerNextLevel(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToPokerNextLevel", sender: sender)
    }
    
    func performSegueQuitColorGame(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToQuitColorGame", sender: sender)
    }
    
    func performSegueRetryDriftBall(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToRetryDriftBall", sender: sender)
    }
    
    func performSegueResetDriftBall(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToResetDriftBall", sender: sender)
    }
    
    func performSegueQuitDriftBall(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToQuitDriftBall", sender: sender)
    }
    
    func performSegueNextDriftBall(sender: UIButton!)
    {
        performSegueWithIdentifier("unwindToNextDriftBall", sender: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
