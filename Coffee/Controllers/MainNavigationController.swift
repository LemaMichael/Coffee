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
        
        if connectedToInternet() {
            self.pushViewController(ViewController(), animated: false)
        } else {
            //: Display error 
            
        }
    }
    
    fileprivate func connectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
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
