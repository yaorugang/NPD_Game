//
//  PokerGameViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 16/04/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class PokerGameViewController: UIViewController
{
    @IBOutlet weak var MessageLabel: UILabel!
    @IBOutlet weak var SeedPoker: UIImageView!
    @IBOutlet weak var PokerImageViewListContainer: UIView!
    
    var PokerImageViewList = [UIImageView]()
    var PokerImageList = [UIImage]()                                      // storing a set of porkers
    var QuestionMarkImage = UIImage(named: "QuestionMark")
    
    var timeLimitArray = [3.0, 3.0, 3.0, 2.0, 2.0, 2.0, 1.0, 1.0, 1.0]    // time limit for each sublevel
    var guessTimesArray = [1, 2, 3]                                       // guess times for each level
    
    var currentLevel: Int = -1
    var currentSublevel: Int = -1
    var tryTimes = 0                                                      // times have tried
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // set background color
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 207.0/255, alpha: 1)
        
        // load 54 porkers
        for index in 0...53
        {
            var pokerImage = UIImage(named: "Poker-" + String(index))
            PokerImageList.append(pokerImage!)
        }
    }
    
    override func viewDidAppear(animated: Bool)
    {
        startLevel0()
    }
    
    func startLevel0()
    {
        currentLevel = 0
        clearPokerImageViewContainer()
        
        // dynamically create and add image views to the container, and then perform layout
        var span = PokerImageViewListContainer.frame.width * 0.05
        var width = (PokerImageViewListContainer.frame.width - 2 * span) / 3
        var height = width * 1.5
        var y = (PokerImageViewListContainer.frame.height - height) / 2
        
        for index in 0...2
        {
            var poker = UIImageView()
            
            poker.highlightedImage = QuestionMarkImage
            poker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performClick:"))    // add click event function
          
            PokerImageViewList.append(poker)
            PokerImageViewListContainer.addSubview(poker)
            
            var x = (span + width) * CGFloat(index)
            poker.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    
        runGame(0)
    }
    
    func startLevel1()
    {
        currentLevel = 1
        clearPokerImageViewContainer()
        
        // dynamically create and add image views to the container, and then perform layout
        var span = PokerImageViewListContainer.frame.width * 0.05
        var width = (PokerImageViewListContainer.frame.width - 2 * span) / 3
        var height = width * 1.5
        var y = (PokerImageViewListContainer.frame.height - height * 2 - span) / 2
        
        for i in 0...1
        {
            var point_y = (height + span) * CGFloat(i) + y
            
            for j in 0...2
            {
                var point_x = (width + span) * CGFloat(j)
                
                var poker = UIImageView()
                
                poker.highlightedImage = QuestionMarkImage
                poker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performClick:"))    // add click event function
                
                PokerImageViewList.append(poker)
                PokerImageViewListContainer.addSubview(poker)
                
                poker.frame = CGRect(x: point_x, y: point_y, width: width, height: height)
            }
        }
        
        runGame(0)
    }
    
    func startLevel2()
    {
        currentLevel = 2
        clearPokerImageViewContainer()
        
        // dynamically create and add image views to the container, and then perform layout
        var span_y = PokerImageViewListContainer.frame.height * 0.02
        var height = (PokerImageViewListContainer.frame.height - 2 * span_y) / 3
        var width = height / 1.5
        var span_x = (PokerImageViewListContainer.frame.width - width * 3) / 2
        
        for i in 0...2
        {
            var point_y = (height + span_y) * CGFloat(i)
            
            for j in 0...2
            {
                var point_x = (width + span_x) * CGFloat(j)
                
                var poker = UIImageView()
                
                poker.highlightedImage = QuestionMarkImage
                poker.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performClick:"))    // add click event function
                
                PokerImageViewList.append(poker)
                PokerImageViewListContainer.addSubview(poker)
                
                poker.frame = CGRect(x: point_x, y: point_y, width: width, height: height)
            }
        }
        
        runGame(0)
    }
    
    /* start run game with a given sub-level */
    func runGame(subLevel: Int)
    {
        currentSublevel = subLevel
        tryTimes = 1
        
        updateMessageBar()
        
        // randomly choose pokers to show
        var tempList = [UIImage](PokerImageList) // create a temporary poker list, which is copied from the PokerList
        
        for item in PokerImageViewList
        {
            var index = Int(arc4random_uniform(UInt32(tempList.count)))
            item.image = tempList[index]
            item.highlighted = false
            item.userInteractionEnabled = false
            tempList.removeAtIndex(index)
        }
        
        // randomly choose a poker as seed
        var index = Int(arc4random_uniform(UInt32(PokerImageViewList.count)))
        SeedPoker.image = PokerImageViewList[index].image
        
        // set a timer to turn over pokers
        NSTimer.scheduledTimerWithTimeInterval(timeLimitArray[subLevel], target: self, selector: Selector("turnOverPokers"), userInfo: nil, repeats: false)
    }
   
    /* to turn over all optional pokers, ask user to guess which one is the target.
       the action is actually implemented by turning image view to highlight. Meanwhile, to activate user interaction */
    func turnOverPokers()
    {
        for item in PokerImageViewList
        {
            item.highlighted = true
            item.userInteractionEnabled = true
        }
    }
    
    /* check wether the chosen poker is as same as the seed. This function is a click event of poker image views */
    func performClick(sender: UITapGestureRecognizer)
    {
        if (sender.state == UIGestureRecognizerState.Ended)
        {
            var pokerIV = sender.view as! UIImageView
            
            pokerIV.highlighted = false
    
            // after turning the poker over, it requires to wait a period of time to perform check process.
            NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("performCheck:"), userInfo: pokerIV, repeats: false)
        }
    }
    
    func performCheck(timer: NSTimer)
    {
        var pokerIV = timer.userInfo as! UIImageView
        
        if (pokerIV.image === SeedPoker.image)  // process correct guess
        {
            if (currentSublevel < 8)
            {
                runGame(currentSublevel + 1)    // go to next sub-level
            }
            else
            {
                var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                self.presentViewController(popup, animated: false, completion: nil)
                
                if (currentLevel < 2)   // has more level to play
                {
                    popup.showPokerGameNextLevel()
                }
                else                    // no more level
                {
                    popup.showPokerGameWin()
                }
            }
        }
        else                                    // process wrong guess
        {
            // check whether it's exceeded max guess times
            if (tryTimes < guessTimesArray[currentLevel])
            {
                pokerIV.highlighted = true
                tryTimes++
            }
            else
            {
                var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
                self.presentViewController(popup, animated: false, completion: nil)
                popup.showPokerGameReset()
                
                saveGameRecord()
            }
        }
    }

    func updateMessageBar()
    {
        MessageLabel.text = "Question \(currentSublevel + 1) of 9 of level \(currentLevel + 1)"
    }
    
    func clearPokerImageViewContainer()
    {
        PokerImageViewList.removeAll(keepCapacity: false)
        
        for iv in PokerImageViewListContainer.subviews
        {
            iv.removeFromSuperview()
        }
    }
    
    /* restart game from leve 1, sublevel 1 */
    @IBAction func unwindPokerGameReset(segue: UIStoryboardSegue)
    {
        startLevel0()
    }

    @IBAction func unwindPokerGameNextLevel(segue: UIStoryboardSegue)
    {
        switch (currentLevel)
        {
        case 0:
            startLevel1()
        case 1:
            startLevel2()
        default:
             break
        }
        
    }
    
    func saveGameRecord()
    {
        var gameInfo = GameInfo()
        gameInfo.pid = gGameUser.id
        gameInfo.gid = 5
        gameInfo.level = currentLevel + 1
        gameInfo.time = 0
        gameInfo.score = (currentLevel + 1) * 20 + (currentSublevel + 1) * 10
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
    
    @IBAction func unwindPokerGameQuit(segue: UIStoryboardSegue)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
