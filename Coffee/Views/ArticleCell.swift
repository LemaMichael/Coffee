//
//  ArticleCell.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    let bubble: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor(red:0.01, green:0.70, blue:1.00, alpha:1.00) //read
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()
    
    let newsTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 18)
        label.text = "US News"
        return label
    }()
    
    let headingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(count: String, color: UIColor) {
        bubble.setTitle(count, for: .normal)
        bubble.layer.borderColor = color.cgColor
        newsTypeLabel.textColor = color
        
        fill(color: color)
        let readArray = UserDefaults.standard.getNewsRead()
        let articleNumber = Int(count) ?? 1
        if !readArray.contains(articleNumber) {
            UserDefaults.standard.setNewsAsRead(value: articleNumber)
        }
    }
    
    func update(title: String, body: String) {
        headingLabel.text = title
        bodyLabel.text = body
    }
    
    func fill(color: UIColor) {
        // todo animate the fill to let reader know the artcle has now been read
        self.bubble.setTitleColor(.white, for: .normal)
        self.bubble.backgroundColor = color
    }
    
    func setupCell() {
        self.addSubview(bubble)
        self.addSubview(newsTypeLabel)
        self.addSubview(headingLabel)
        self.addSubview(bodyLabel)
        
        if UserDefaults.standard.isDarkMode() {
            self.backgroundColor = .black
            self.headingLabel.textColor = .white
            self.bodyLabel.textColor = .white
        } else {
            self.bodyLabel.textColor = .black
            self.backgroundColor = .white
            self.headingLabel.textColor = .black
        }
    }
    
    func setupConstraints() {
        let customHeight = UIScreen.main.bounds.height - Header.shared.height
        
        bubble.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, paddingTop: customHeight * 0.052, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 30, height: 30)
        
        newsTypeLabel.anchor(top: nil, bottom: nil, left: bubble.rightAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 150, height: 25)
        newsTypeLabel.centerYAnchor.constraint(equalTo: bubble.centerYAnchor).isActive = true
        
        headingLabel.anchor(top: newsTypeLabel.bottomAnchor, bottom: nil, left: bubble.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 4, paddingRight: 20, width: 0, height: customHeight * 0.4)
        
        bodyLabel.anchor(top: headingLabel.bottomAnchor, bottom: self.bottomAnchor, left: headingLabel.leftAnchor, right: headingLabel.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        

    }
}
