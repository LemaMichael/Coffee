//
//  BubbleCell.swift
//  Coffee
//
//  Created by Michael Lema on 9/19/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class BubbleCell: UICollectionViewCell {
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.App.gray
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(countLabel)
        countLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.App.gray.cgColor
    }
    
    func fill(color: UIColor) {
        self.countLabel.textColor = .white
        self.contentView.backgroundColor = color
        self.contentView.layer.borderColor = color.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
