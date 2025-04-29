//
//  TimeData.swift
//  uikit_sample
//
//  Created by TshujiTakayuki on 2025/04/25.
//

import Foundation

struct TimeData:Codable{
    let taskName:String
    let starttime:Date
    let endtime:Date
    /*let hour:Int
    let minutes:Int
    let secound:Int*/
    
    var duration:TimeInterval{
        return endtime.timeIntervalSince(starttime)
    }
}
