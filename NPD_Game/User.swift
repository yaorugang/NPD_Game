//
//  User.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 2/06/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import Foundation

struct User
{
    var id: Int             = -1
    var name: String        = ""
    var age: Int            = 0
    var pipeLevel: Int      = 0
    var ballLevel: Int      = 0
    var balloonLevel: Int   = 0
    var colorLevel: Int     = 0
    var pokerLevel: Int     = 0
    var breakoutLevel: Int  = 0
}

struct GameInfo
{
    var pid: Int?
    var gid: Int?
    var time: Int?
    var level: Int?
    var score: Int?
    var percent: Int?
    var accuracy: Int?
}