//
//  Header.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

class Header {
    static let shared: Header = {
        let instance = Header(height: UIScreen.main.bounds.height * 0.75, cutOff: 80)
        return instance
    }()
    
    var height: CGFloat
    var cutOff: CGFloat
    
    init(height: CGFloat, cutOff: CGFloat) {
        self.height = height
        self.cutOff = cutOff
    }
}
