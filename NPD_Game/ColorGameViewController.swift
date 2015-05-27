//
//  ColorGameViewController.swift
//  NPD_Game
//
//  Created by yaorugang on 15/4/27.
//  Copyright (c) 2015年 ___YAORUGANG___. All rights reserved.
//

import UIKit

class ColorGameViewController: UIViewController
{
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ColorView: UIView!
    @IBOutlet weak var ColorText: UILabel!
    @IBOutlet weak var MessageBar: UILabel!
    @IBOutlet weak var ColorBlack: UILabel!
    @IBOutlet weak var ColorBlue: UILabel!
    @IBOutlet weak var ColorGreen: UILabel!
    @IBOutlet weak var ColorRed: UILabel!
    @IBOutlet weak var ColorYellow: UILabel!
    @IBOutlet weak var ColorGray: UILabel!
    
    
    let messageArray = ["Choose the meaning of the word", "Choose the color of the ink"]
    let colorArray = [UIColor.blackColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.redColor(), UIColor.yellowColor(), UIColor.grayColor()]
    let colorTextArray = ["BLACK", "BLUE", "GREEN", "RED", "YELLOW", "GRAY"]
    var matchType = 0   // 0: meaning of the word; 1: color of the ink
    var colorIndex = 0
    var colorTextIndex = 0
    var currentScore = 0
    var timeLimit = 0
    var timer: NSTimer?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // set background color
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 207.0/255, alpha: 1)

        
        // initialize color labels
        ColorBlack.userInteractionEnabled = true
        ColorBlue.userInteractionEnabled = true
        ColorGreen.userInteractionEnabled = true
        ColorRed.userInteractionEnabled = true
        ColorYellow.userInteractionEnabled = true
        ColorGray.userInteractionEnabled = true
        
        ColorBlack.backgroundColor = colorArray[0]
        ColorBlue.backgroundColor = colorArray[1]
        ColorGreen.backgroundColor = colorArray[2]
        ColorRed.backgroundColor = colorArray[3]
        ColorYellow.backgroundColor = colorArray[4]
        ColorGray.backgroundColor = colorArray[5]
        
        ColorBlack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        ColorBlue.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        ColorGreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        ColorRed.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        ColorYellow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        ColorGray.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "performCheck:"))
        
        ColorBlack.tag = 0
        ColorBlue.tag = 1
        ColorGreen.tag = 2
        ColorRed.tag = 3
        ColorYellow.tag = 4
        ColorGray.tag = 5
    }
    
    override func viewDidAppear(animated: Bool)
    {
        runGame()
    }
    
    func runGame()
    {
        // update score
        updateScore()
        
        // randomly choose color and color text
        colorIndex = Int(arc4random_uniform(6))
        colorTextIndex = Int(arc4random_uniform(6))
        
        // present background color and set color text
        ColorView.backgroundColor = colorArray[colorIndex]
        ColorText.textColor = colorArray[colorIndex]
        ColorText.text = colorTextArray[colorTextIndex]
        
        // randomly choose match type
        matchType = Int(arc4random_uniform(2))
        updateMessage()
        
        // initialize time limit and then start timer
        timeLimit = computeTimeLimit()
        updateTime()
        timer?.invalidate() // stop the previous timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("onTimerTask"), userInfo: nil, repeats: true) // start a new timer
    }
    
    func updateMessage()
    {
        MessageBar.text = matchType == 0 ? messageArray[0] : messageArray[1]
    }
    
    func updateScore()
    {
        ScoreLabel.text = "Score: \(currentScore)"
    }
    
    func updateTime()
    {
        TimeLabel.text = "Time: \(timeLimit)s"
    }
    
    /* compute time limit. As the score increases, the time limit decreases, down to a minimum of 2 seconds*/
    func computeTimeLimit() -> Int
    {
        let decrease = (Int)(currentScore / 20)
        
        var t = 10 - decrease
        if (t < 2)
        {
            t = 2
        }
        
        return t
    }
    
    /* implementation of timer task */
    func onTimerTask()
    {
        timeLimit--
        
        if (timeLimit >= 0)
        {
            updateTime()
        }
        else
        {
            performGameOver()
        }
    }
    
    func performCheck(sender: UITapGestureRecognizer)
    {
        if (sender.state == UIGestureRecognizerState.Ended)
        {
            var colorLabel = sender.view as! UILabel
            
            var targetIndex = matchType == 0 ? colorTextIndex : colorIndex
            
            if (targetIndex == colorLabel.tag)  // color matched
            {
                performNextLevel()
            }
            else                                // color not matched
            {
                performGameOver()
            }
        }
    }
    
    func performNextLevel()
    {
        currentScore += 10  // increase score by 10
        runGame()
    }
    
    func performGameOver()
    {
        timer?.invalidate() // stop timer
        
        var popup = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationController") as! NotificationViewController;
        self.presentViewController(popup, animated: false, completion: nil)
        popup.showColorGameOver(currentScore)
    }
    
    @IBAction func unwindColorGameQuit(segue: UIStoryboardSegue)
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
