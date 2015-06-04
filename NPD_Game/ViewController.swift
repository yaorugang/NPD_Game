//
//  ViewController.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 6/02/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import UIKit

var gGameUser = User()
let gGameDBAdapter = DBAdapter()

class ViewController: UIViewController
{
    
    
    @IBOutlet weak var usernameEdit: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Login(sender: AnyObject)
    {
        gGameDBAdapter.checkUser(usernameEdit.text, user: &gGameUser)
        
        if (gGameUser.id > 0)
        {
            performSegueWithIdentifier("segueToMenuView", sender: sender)
        }
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
}

