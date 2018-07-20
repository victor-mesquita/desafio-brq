//
//  CarDetailViewController.swift
//  CGShop
//
//  Created by mac on 20/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit

class CarDetailViewController : UIViewController {

    @IBAction func onClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalhes do carro"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
