//
//  GameoverViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 13/02/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

class GameoverViewController: UIViewController
{

    @IBOutlet weak var mGameover: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mGameover.alpha = 1
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        // Make the 'Gameover' image fading
        UIView.animateWithDuration(4.0, animations: {self.mGameover.alpha = 0})
        NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: Selector("closeGameoverView"), userInfo: nil, repeats: false)
    }
    
    func closeGameoverView()
    {
        self.performSegueWithIdentifier("Segue_Gameover", sender: self)
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
