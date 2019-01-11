//
//  CarDetailViewController.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

class CarDetailViewController : UIViewController {
    
    var presenter = CarDetailPresenter()
    
    @IBAction func onClick(_ sender: Any) {
//        closeView()
    }
    
    override func viewDidLoad() {
        presenter.attachToView(viewController: self)
    }
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var lbCarPrice: UILabel!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var lbContentDescrition: UILabel!
    

}
