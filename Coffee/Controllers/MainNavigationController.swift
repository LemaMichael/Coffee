//
//  MainNavigationController.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isLoggedIn() {
            self.pushViewController(ViewController(), animated: false)
        }
    }
    
    fileprivate func isLoggedIn() -> Bool {
        return true
    }
    
    //: MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
