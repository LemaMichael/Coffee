//
//  FloatingPoint+Round.swift
//  Coffee
//
//  Created by Michael Lema on 9/27/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation

public extension FloatingPoint {
    /// Rounds the double to decimal places value
    func roundTo(places: Int) -> Self {
        let divisor = Self(Int(pow(10.0, Double(places))))
        return (self * divisor).rounded() / divisor
    }
}

