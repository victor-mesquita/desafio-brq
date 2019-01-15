//
//  UICarCollectionViewCell.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import UIKit

class UICarCollectionViewCell: UICollectionViewCell {

    static let nib = UINib(nibName: "UICarCollectionViewCell", bundle: nil)
    
    @IBOutlet weak var lbCarPrice: UILabel!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var ivCar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
