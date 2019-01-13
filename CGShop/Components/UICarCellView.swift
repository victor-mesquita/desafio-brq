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
    
    private var nibName = "UICarCellView"
    private var view: UIView! = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupXib()
    }
    
    func setupXib()
    {
        view = loadViewFromNib()
        
        if(view != nil) {
            view.frame = bounds
            
            addSubview(view)
        }else{
            fatalError("Failed to load xib from file!")
        }
    }
    
    func loadViewFromNib() -> UIView {
        let viewBundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: viewBundle)
        
        let view =  nib.instantiate(withOwner: self, options: nil)[0] as! UIView;
        
        return view
    }
}
