//
//  NewsTableViewCell.swift
//  Coffee
//
//  Created by Michael Lema on 9/16/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var newsCategory: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var newsTitle: UILabel = {
        let title = UILabel()
        return title
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.newsTitle.textColor = UIColor.black
        self.newsTitle.numberOfLines = 0
        self.newsTitle.sizeToFit()
        
    }
    func setupCell() {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
