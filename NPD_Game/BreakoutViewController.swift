//
//  BreakoutViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 19/05/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode
{
    class func unarchiveFromFile(file : String) -> SKNode?
    {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        }
        else
        {
            return nil
        }
    }
}


class BreakoutViewController: UIViewController
{
    @IBOutlet weak var dashboardView: UIImageView!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var nextLevelButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    var scene: GameScene?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
        
        
        playerLabel.tag         = 1
        scoreLabel.tag          = 2
        nextLabel.tag           = 3
        highestScoreLabel.tag   = 4
        levelLabel.tag          = 5
        liveLabel.tag           = 6
        rankLabel.tag           = 7
        retryButton.tag         = 8
        nextLevelButton.tag     = 9
        quitButton.tag          = 10
        
        // Configure the view.
        let skView = SKView(frame: CGRectMake(0, 0, view.frame.width - dashboardView.frame.width, view.frame.height))
        self.view.addSubview(skView)
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = SKSceneScaleMode.Fill
    
        skView.presentScene(scene)

        // set three buttons
        self.view.bringSubviewToFront(retryButton)
        self.view.bringSubviewToFront(nextLevelButton)
        self.view.bringSubviewToFront(quitButton)
        dismissButtons()
        
    }
    
    override func shouldAutorotate() -> Bool
    {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int
    {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        }
        else
        {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    func dismissButtons()
    {
        retryButton.hidden = true
        nextLevelButton.hidden = true
        quitButton.hidden = true
    }
    
    @IBAction func performRetry(sender: AnyObject)
    {
        scene!.setLifeLeft(scene!.getLifeLeft() - 1)
        
        switch (scene!.getCurrentLevel())
        {
        case 1:
            scene!.startLevel1()
        case 2:
            scene!.startLevel2()
        default:
            break
        }
        
        dismissButtons()
    }
    
    @IBAction func performNextLevel(sender: AnyObject)
    {
        if (scene!.getCurrentLevel() == 1)
        {
            scene!.setLifeLeft(1)
            scene!.startLevel2()
        }
        
        dismissButtons()
    }
    
    @IBAction func performQuit(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
