//
//  NotificationViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 23/05/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController
{
    @IBOutlet weak var mMessageLabel: UILabel!
    @IBOutlet weak var mResetButton: UIButton!
    @IBOutlet weak var mRetryButton: UIButton!
    @IBOutlet weak var mNextLevelButton: UIButton!
    @IBOutlet weak var mQuitButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set background to be a certain scale of transparence.
        self.view.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.8)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPipeGameNextLevel()
    {
        mMessageLabel.text = "You can go to the next level."
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        
        mNextLevelButton.tag = 1
        mNextLevelButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mQuitButton.tag = 2
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPipeGameWin()
    {
        mMessageLabel.text = "You Win!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 2
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPipeGameOver()
    {
        mMessageLabel.text = "Game Over!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 2
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showBalloonGameNextLevel()
    {
        mMessageLabel.text = "You can go to the next level."
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        
        mNextLevelButton.tag = 3
        mNextLevelButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mQuitButton.tag = 4
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showBalloonGameWin()
    {
        mMessageLabel.text = "You Win!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 4
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showBalloonGameOver()
    {
        mMessageLabel.text = "Game Over!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 4
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    func showPokerGameReset()
    {
        mMessageLabel.text = "You can reset game."
        
        mResetButton.tag = 5
        mResetButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 7
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPokerGameNextLevel()
    {
        mMessageLabel.text = "You can go to the next level."
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        
        mNextLevelButton.tag = 6
        mNextLevelButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mQuitButton.tag = 7
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showPokerGameWin()
    {
        mMessageLabel.text = "You Win!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 7
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showColorGameOver(var score: Int)
    {
        mMessageLabel.text = "Congratulations!\nYour score is \(score)"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 8
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showDriftGameOver(var score: Float)
    {
        mMessageLabel.text = "Fail!\nYour score is \(score) seconds"
        
        mResetButton.tag = 9
        mResetButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mRetryButton.tag = 10
        mRetryButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 12
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showDriftGameNextLevel(var score: Float)
    {
        mMessageLabel.text = "Congratulations!\nYour score is \(score) seconds"
        
        mResetButton.tag = 9
        mResetButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mRetryButton.tag = 10
        mRetryButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mNextLevelButton.tag = 11
        mNextLevelButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
        
        mQuitButton.tag = 12
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func showDriftGameWin()
    {
        mMessageLabel.text = "Congratulations!\nYour win!"
        
        mResetButton.hidden = true
        mRetryButton.hidden = true
        mNextLevelButton.hidden = true
        
        mQuitButton.tag = 12
        mQuitButton.addTarget(self, action: "performSegue:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func performSegue(sender: UIButton)
    {
        switch (sender.tag)
        {
        case 1:     // pipe game next level
            performSegueWithIdentifier("unwindPipeGameNextLevel", sender: sender)
        case 2:     // pipe game quit
            performSegueWithIdentifier("unwindPipeGameQuit", sender: sender)
        case 3:     // balloon game next level
            performSegueWithIdentifier("unwindBalloonGameNextLevel", sender: sender)
        case 4:     // balloon game quit
            performSegueWithIdentifier("unwindBalloonGameQuit", sender: sender)
        case 5:     // poker game reset
            performSegueWithIdentifier("unwindPokerGameReset", sender: sender)
        case 6:     // poker game next level
            performSegueWithIdentifier("unwindPokerGameNextLevel", sender: sender)
        case 7:     // poker game quit
            performSegueWithIdentifier("unwindPokerGameQuit", sender: sender)
        case 8:     // color game quit
            performSegueWithIdentifier("unwindColorGameQuit", sender: sender)
        case 9:     // drift game reset
            performSegueWithIdentifier("unwindDriftGameReset", sender: sender)
        case 10:    // drift game retry
            performSegueWithIdentifier("unwindDriftGameRetry", sender: sender)
        case 11:    // drift game next level
            performSegueWithIdentifier("unwindDriftGameNextLevel", sender: sender)
        case 12:    // drift game quit
            performSegueWithIdentifier("unwindDriftGameQuit", sender: sender)
        default:
            break;
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
