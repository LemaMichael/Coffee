//
//  CircleLayout.swift
//  Coffee
//
//  Created by Michael Lema on 9/19/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

fileprivate let ITEM_SIZE: CGFloat = 40

class CircleLayout: UICollectionViewLayout {
    var center: CGPoint = CGPoint()
    var radius: CGFloat = CGFloat()
    var cellCount: Int = Int()
    
    
    override func prepare() {
        super.prepare()
        
        let size = self.collectionView!.frame.size
        cellCount = self.collectionView!.numberOfItems(inSection: 0)
        center = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        radius = min(size.width, size.height) / 2.5
    }
    
    override var collectionViewContentSize : CGSize {
        return self.collectionView!.frame.size
    }
    
    override func layoutAttributesForItem(at path: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: path)
        attributes.size = CGSize(width: ITEM_SIZE, height: ITEM_SIZE)
        attributes.center = CGPoint(x: center.x + radius * sin(2 * CGFloat(path.item) * .pi / CGFloat(cellCount)),
                                    y: center.y + radius * -cos(2 * CGFloat(path.item) * .pi / CGFloat(cellCount)))
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes: [UICollectionViewLayoutAttributes] = []
        for i in 0..<self.cellCount {
            let indexPath = IndexPath(item: i, section: 0)
            attributes.append(self.layoutAttributesForItem(at: indexPath)!)
        }
        return attributes
    }
    

    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attributes = self.layoutAttributesForItem(at: itemIndexPath)!
        attributes.alpha = 0.0
        attributes.center = CGPoint(x: center.x, y: center.y)
        return attributes
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = self.layoutAttributesForItem(at: itemIndexPath)!
        attributes.alpha = 0.0
        attributes.center = CGPoint(x: center.x, y: center.y)
        attributes.transform3D = CATransform3DMakeScale(0.1, 0.1, 1.0)
        return attributes
    }
    
}
