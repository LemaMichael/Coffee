//
//  UserDefaultsExtension.swift
//  Coffee
//
//  Created by Michael Lema on 9/23/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    enum UserDefaultKeys: String {
        case newsRead
    }
    
    func setNewsAsRead(value: Int) {
        var readArray = getNewsRead()
        if !readArray.contains(value) {
            readArray.append(value)
        }
        set(readArray, forKey: UserDefaultKeys.newsRead.rawValue)
        synchronize()
    }
    func getNewsRead() -> [Int] {
        guard let readArray = array(forKey: UserDefaultKeys.newsRead.rawValue) as? [Int] else { return [] }
        return readArray
    }
    
    
}
