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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "Error"))
        imageView.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.88, alpha:1.00)
        self.view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
