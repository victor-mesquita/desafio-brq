//
//  UICarCellView.swift
//  CGShop
//
//  Created by Victor Mesquita on 01/01/2019.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UICarCellView: UICollectionViewCell {
    
    @IBOutlet weak var ivCarImage: UIImageView!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var lbCarPrice: UILabel!
    
    var view: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
     
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let viewBundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "UICarCellView", bundle: viewBundle)
        
        let view =  nib.instantiate(withOwner: self, options: nil)[0] as! UIView;
        
        return view
    }
    
}
