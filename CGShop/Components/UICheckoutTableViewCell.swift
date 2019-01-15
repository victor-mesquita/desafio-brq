//
//
//  TesteDoXibTableViewCell.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import UIKit

class UICheckoutTableViewCell: UITableViewCell {
    static let nib = UINib(nibName: "UICheckoutTableViewCell", bundle: nil)
    
    @IBOutlet weak var lbCarPrice: UILabel!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var lbAmount: UILabel!
    @IBOutlet weak var ivCar: UIImageView!
    
    @IBOutlet weak var onClickRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
