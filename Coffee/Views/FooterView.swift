//
//  FooterCell.swift
//  Coffee
//
//  Created by Michael Lema on 9/18/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class FooterView: UITableViewHeaderFooterView {
    
    let bubbleId = "bubbleId"
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CircleLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let readLabel: UILabel = {
       let label = UILabel()
        label.text = "You've read"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        return label
    }()
    let countLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserDefaults.standard.getNewsRead().count) of 10"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue", size: 41)
        return label
    }()
    
    let readMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Read more news"
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "MoreIcon"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.App.gray
        return button
    }()
    
    @objc func moreButtonTapped() {
        print("Tapped!")
    }
    
    func updateReadCount(index: IndexPath, fillColor: UIColor)  {
        let readArray = UserDefaults.standard.getNewsRead()
        countLabel.text = "\(readArray.count) of 10"
        
        // Update bubble background color
        let cell = collectionView.cellForItem(at: index) as! BubbleCell
        cell.fill(color: fillColor)
    }
    
    func updateViews() {
        countLabel.text = "\(UserDefaults.standard.getNewsRead().count) of 10"
        collectionView.reloadData()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(divider)
        addSubview(collectionView)
        collectionView.addSubview(readLabel)
        collectionView.addSubview(countLabel)
        addSubview(readMoreLabel)
        addSubview(moreButton)
        
        setupConstraints()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BubbleCell.self, forCellWithReuseIdentifier: bubbleId)
        collectionView.reloadData()
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        if UserDefaults.standard.isDarkMode() {
            self.contentView.backgroundColor = .black
            self.readLabel.textColor = .white
            self.countLabel.textColor = .white
            self.readMoreLabel.textColor = .white
        } else {
            self.contentView.backgroundColor = .white
            self.readLabel.textColor = .black
            self.countLabel.textColor = .white
            self.readMoreLabel.textColor = .black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupConstraints() {
        //self.contentView.backgroundColor = .red
        let customVal = UIScreen.main.bounds.width * 0.82
        divider.anchor(top: self.topAnchor, bottom: nil, left: self.leftAnchor, right: self.rightAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 20, paddingRight: 0, width: 0, height: 0.5)
        
        collectionView.anchor(top: divider.bottomAnchor, bottom: nil, left: nil, right: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width:  customVal, height: customVal)
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        countLabel.anchor(top: nil, bottom: nil, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: customVal * 0.5, height: 32)
        countLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        countLabel.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
        readLabel.anchor(top: nil, bottom: countLabel.topAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: -3, paddingLeft: 0, paddingRight: 0, width: customVal * 0.4, height: 28)
        readLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        
        moreButton.anchor(top: nil, bottom: self.bottomAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 30, height: 30)
        moreButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        readMoreLabel.anchor(top: nil, bottom: moreButton.topAnchor, left: nil, right: nil, paddingTop: 0, paddingBottom: -2, paddingLeft: 0, paddingRight: 0, width: customVal * 0.5, height: 24)
        readMoreLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
}

extension FooterView: UICollectionViewDelegate {
}

extension FooterView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bubbleId, for: indexPath) as! BubbleCell
        cell.setup(color: UIColor.App.allColors[indexPath.item], index: indexPath)
        return cell
    }
    
}
