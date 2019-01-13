//
//  CartCarDetailView.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/13/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

class CartCarDetailView: UIView {
    private var nibName = "CartCarDetailView"
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
