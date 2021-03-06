//
//  NewsCell.swift
//  Coffee
//
//  Created by Michael Lema on 9/16/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    let bubble: UIButton = {
        let button = UIButton()
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
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let headingLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let subHeadingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.45, green:0.46, blue:0.48, alpha:1.00)
        label.numberOfLines = 1
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let wikiIcon: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(named: "Wiki")
        marker.contentMode = .scaleAspectFit
        return marker
    }()
    let markerIcon: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(named: "Marker")
        marker.contentMode = .scaleAspectFit
        return marker
    }()
    let mountainIcon: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(named: "Mountain")
        marker.contentMode = .scaleAspectFit
        return marker
    }()
    let twitterIcon: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(named: "Twitter")
        marker.contentMode = .scaleAspectFit
        return marker
    }()
    
    lazy var itemsStackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(wikiIcon)
        sv.addArrangedSubview(markerIcon)
        sv.addArrangedSubview(mountainIcon)
        sv.addArrangedSubview(twitterIcon)
        sv.distribution = .equalCentering
        sv.axis = .horizontal
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(color: UIColor, index: IndexPath) {
        bubble.setTitle("\(index.item + 1)", for: .normal)
        bubble.layer.borderColor = color.cgColor
        newsTypeLabel.textColor = color
        
        let readArray = UserDefaults.standard.getNewsRead()
        if readArray.contains(index.item + 1) {
            fill(color: color)
        } else {
            unfill(color: color)
        }
    }
    func fill(color: UIColor) {
        self.bubble.setTitleColor(.white, for: .normal)
        self.bubble.backgroundColor = color
    }
    
    func unfill(color: UIColor) {
        bubble.setTitleColor(color, for: .normal)
        self.bubble.backgroundColor = UserDefaults.standard.isDarkMode()  ? .black : .white
    }
    
    func update(title: String, source: String) {
        headingLabel.text = title
        var source = source.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
        source = source.replacingOccurrences(of: ".com", with: "")
        //source.replaceSubrange(source.startIndex..<source.index(source.startIndex, offsetBy: 1), with: String(source[source.startIndex]).capitalized)
        subHeadingLabel.text = source.capitalized
    }
    
    func setupCell() {
        self.addSubview(bubble)
        self.addSubview(newsTypeLabel)
        self.addSubview(headingLabel)
        self.addSubview(subHeadingLabel)
        self.addSubview(itemsStackView)
        
        if UserDefaults.standard.isDarkMode() {
            self.backgroundColor = .black
            self.headingLabel.textColor = .white
        } else {
            self.backgroundColor = .white
            self.headingLabel.textColor = .black
        }
    }
    
    func setupConstraints() {
        let customHeight = UIScreen.main.bounds.height - Header.shared.height
        bubble.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: nil, paddingTop: customHeight * 0.07, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 30, height: 30)
        
        newsTypeLabel.anchor(top: nil, bottom: nil, left: bubble.rightAnchor, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 8, paddingRight: 0, width: 150, height: 25)
        newsTypeLabel.centerYAnchor.constraint(equalTo: bubble.centerYAnchor).isActive = true
        
        headingLabel.anchor(top: newsTypeLabel.bottomAnchor, bottom: nil, left: newsTypeLabel.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 20, width: 0, height: customHeight * 0.4)
        
        subHeadingLabel.anchor(top: headingLabel.bottomAnchor, bottom: nil, left: newsTypeLabel.leftAnchor, right: self.rightAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: customHeight * 0.15)
        
        itemsStackView.anchor(top: subHeadingLabel.bottomAnchor, bottom: nil, left: headingLabel.leftAnchor, right: nil, paddingTop: 4, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 118, height: 30)

        wikiIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        markerIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        mountainIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        twitterIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
