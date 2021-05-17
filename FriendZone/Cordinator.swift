//
//  Cordinator.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import UIKit

protocol Cordinator {
    var childCoordnator: [Cordinator] { get set }
    var navigationController: UINavigationController { get set }
     
    func start()
 
}
