//
//  RootViewController.swift
//  CGShop
//
//  Created by mac on 16/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class RootViewController: UIViewController, UIPageViewControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var cars = [Car]()
    
    @IBOutlet weak var tvProducts: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productitem") as! TableViewCell
        
        let car:Car = cars[indexPath.row]
        
        cell.lProductName.text = car.nome
        
        let borderColor = UIColor(red:102/255, green:102/255, blue:102/255, alpha:1.0)
        
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = borderColor.cgColor
        
        cell.ivProduct.kf.setImage(with: URL(string: car.imagem!))
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
    
        NLCar.list{ (result: Result<[Car]>) in
            self.cars = result.value!
            
            self.tvProducts.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

