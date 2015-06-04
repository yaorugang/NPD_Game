//
//  DBAdapter.swift
//  NPD_Game
//
//  Created by RUGANG YAO on 2/06/2015.
//  Copyright (c) 2015 ___YAORUGANG___. All rights reserved.
//

import Foundation

extension String
{
    func stringByAddingPercentEncodingForURLQueryValue() -> String?
    {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
    
}

extension Dictionary
{
    func stringFromHttpParameters() -> String
    {
        let parameterArray = map(self)
            { (key, value) -> String in
                let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
                let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }
        
        return join("&", parameterArray)
    }
}

class DBAdapter
{
    let mServerIP: String           = "localhost"
    let mServerPort: String         = "8080"
    let mServerName: String         = "npd"
    let mLoginServlet: String       = "LoginServlet_iOS"
    let mGameRecordServlet: String  = "InsertGameRecordServlet_iOS"
    
    init()
    {
    }
    
    func checkUser(username: String, inout user: User)
    {
        let url: NSURL = NSURL(string: "http://\(mServerIP):\(mServerPort)/\(mServerName)/\(mLoginServlet)?username=\(username)")!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSErrorPointer = nil
 
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: err) as! NSDictionary

    
        user.id = jsonResult["patientID"] as! Int
        
        if (user.id > 0)
        {
            user.name           = jsonResult["patientName"] as! String
            user.age            = jsonResult["patientAge"] as! Int
            user.ballLevel      = jsonResult["ballLevel"] as! Int
            user.balloonLevel   = jsonResult["balloonLevel"] as! Int
            user.breakoutLevel  = jsonResult["breakoutLevel"] as! Int
            user.colorLevel     = jsonResult["colorLevel"] as! Int
            user.pipeLevel      = jsonResult["pipeLevel"] as! Int
            user.pokerLevel     = jsonResult["pokerLevel"] as! Int
        }
    }
    
    func insertGameRecord(gameinfo: GameInfo) -> Bool
    {
        // get current time
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        let datetime = "\(components.year),\(components.month),\(components.day),\(components.hour),\(components.minute),\(components.second)"
        
        // build parameters of URL
        let paramString = "gid=\(gameinfo.gid!)&pid=\(gameinfo.pid!)&time=\(gameinfo.time!)&level=\(gameinfo.level!)&score=\(gameinfo.score!)&percent=\(gameinfo.percent!)&accuracy=\(gameinfo.accuracy!)&date=\(datetime)"
        
        let url: NSURL = NSURL(string: "http://\(mServerIP):\(mServerPort)/\(mServerName)/\(mGameRecordServlet)?\(paramString)")!
        
        var request: NSURLRequest = NSURLRequest(URL: url)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?> = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSErrorPointer = nil
        
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: err) as! NSDictionary
        
        
        var effect = jsonResult["Effect"] as! String
        var insert = jsonResult["Insert"] as! String
        
        if (effect == "F" || insert == "F")
        {
            return false
        }
        else
        {
            return true
        }
    }
}