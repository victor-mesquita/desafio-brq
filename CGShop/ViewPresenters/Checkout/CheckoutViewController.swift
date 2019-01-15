//
//  CheckoutViewController.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

protocol CheckoutViewProtocol {
    
}

class CheckoutViewController : BaseViewController  {
    var presenter = CheckoutPresenter()
    var checkout: Checkout? = nil
    var checkouted: [Checkout] = [Checkout]()
    
    @IBOutlet weak var tvCheckout: UITableView!
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachToView(viewController: self)
        
        presenter.persistCheckout(checkout: self.checkout!)
        
        setupTableView()
        
        self.checkouted = presenter.listCheckouts()
        
        tvCheckout.reloadData()
    }
    
    func setupTableView(){
        tvCheckout.register(UICheckoutTableViewCell.nib, forCellReuseIdentifier: ReusableIds.Checkout.CHECKOUT_CELL)
    }
    
    override func willSkeleton() -> Bool {
        return false
    }
}

extension CheckoutViewController :  CheckoutViewProtocol {
}

extension CheckoutViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkouted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReusableIds.Checkout.CHECKOUT_CELL, for: indexPath) as! UICheckoutTableViewCell
        
        
        setCellData(cell: cell, indexPath: indexPath)
        
        return cell;
    }
    
    func setCellData(cell: UICheckoutTableViewCell, indexPath: IndexPath){
        let checkout:Checkout = checkouted[indexPath.row]
        
        cell.lbCarName.text = checkout.car.nome
        
        cell.ivCar.kf.setImage(with: URL(string: checkout.car.imagem), placeholder: UIImage(named: "placeholder"))
        
        let preco = String(describing: checkout.car.preco)
        
        cell.lbCarPrice.text = "R$ \(preco)"
        
        cell.lbAmount.text = String(checkout.amount)
    }
}
