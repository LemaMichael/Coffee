//
//  ErrorController.swift
//  Coffee
//
//  Created by Michael Lema on 9/27/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class ErrorViewController: UIViewController {
    
    var checkTimer: Timer!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Error"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.88, alpha:1.00)
        self.view.addSubview(imageView)
        
        imageView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        checkTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(checkWifi), userInfo: nil, repeats: true)
    }
    
    @objc func checkWifi() {
        if Reachability.isConnectedToNetwork() {
            self.navigationController?.pushViewController(ViewController(), animated: false)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        checkTimer.invalidate()
    }
    
}
