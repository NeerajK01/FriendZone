//
//  MainCordinator.swift
//  FriendZone
//
//  Created by Neeraj kumar on 04/02/21.
//  Copyright © 2021 prolifics. All rights reserved.
//

import Foundation
import UIKit

class MainCordinator: Cordinator {
    
    var childCoordnator = [Cordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
    
    
}
