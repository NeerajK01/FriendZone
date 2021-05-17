//
//  TimeFormat.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import Foundation

extension Int{
    func timeString() -> String{
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .positional
        
        let formatterString = formatter.string(from: TimeInterval(self)) ?? "0"
        if formatterString == "0"{
            return "GMT"
        }else{
            if formatterString.hasPrefix("-"){
                return "GMT\(formatterString)"
            }else{
                return "GMT+\(formatterString)"
            }
        }
    }
}
