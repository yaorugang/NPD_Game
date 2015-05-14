//
//  BalloonLevelViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 13/03/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class BalloonLevelViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Set background image.
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "b_sky")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Override the function to return true in order to hide the status bar */
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    @IBAction func performQuit(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func openGameLevel1(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(1)
        self.presentViewController(gameView, animated: false, completion: nil)
    }
    
    @IBAction func openGameLevel2(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(2)
        self.presentViewController(gameView, animated: false, completion: nil)
    }
    
    @IBAction func openGameLevel3(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(3)
        self.presentViewController(gameView, animated: false, completion: nil)
    }
    
    @IBAction func openGameLevel4(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(4)
        self.presentViewController(gameView, animated: false, completion: nil)
    }
    
    @IBAction func openGameLevel5(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(5)
        self.presentViewController(gameView, animated: false, completion: nil)
    }
    
    @IBAction func openGameLevel6(sender: AnyObject)
    {
        var gameView = self.storyboard?.instantiateViewControllerWithIdentifier("BalloonGameController") as!  BalloonGameViewController
        gameView.setGameLevel(6)
        self.presentViewController(gameView, animated: false, completion: nil)
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
