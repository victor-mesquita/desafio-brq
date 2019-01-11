//
//  CarGridFlowLayout.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit

class CarGridFlowLayout: UICollectionViewFlowLayout {

    let itemHeight: CGFloat = 216
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 6
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2)-3
    }
    
    override var itemSize: CGSize {
        set {
            let size : CGSize = CGSize(width: itemWidth(), height: itemHeight)
            self.itemSize = size
        }
        get {
            let size : CGSize = CGSize(width: itemWidth(), height: itemHeight)
            return size
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
