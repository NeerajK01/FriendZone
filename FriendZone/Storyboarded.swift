//
//  Storyboarded.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController{
    static func  instantiate() -> Self{
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: className) as! Self
    }
}
