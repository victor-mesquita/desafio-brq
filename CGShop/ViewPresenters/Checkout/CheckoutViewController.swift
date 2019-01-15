//
//  CheckoutViewController.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit
import Lottie

protocol CheckoutViewProtocol {
    func fetchAndUpdateTableView() -> Void
    func setupTableView() -> Void
    func showPriceLimitExceeded(maxValue: Double)
}

class CheckoutViewController : LoadableViewController  {
    var presenter = CheckoutPresenter()
    var checkout: Checkout? = nil
    var checkouted: [Checkout] = [Checkout]()
    
    @IBOutlet weak var tvCheckout: UITableView!
    @IBOutlet weak var svCheckout: UIStackView!
    @IBOutlet weak var lbNoCar: UILabel!
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickFinalizar(_ sender: Any) {
        presenter.completePurchase()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachToView(viewController: self)
        
        presenter.persistCheckout(checkout: self.checkout!)
        
        setupTableView()
        
        fetchAndUpdateTableView()
    }
    
    override func willSkeleton() -> Bool {
        return false
    }
    
    let completeAnimationView = LOTAnimationView(name: "CompleteAnimation")
    
    func showCompleteAnimation() -> Void {
        completeAnimationView.center = self.view.center
        completeAnimationView.contentMode = .scaleAspectFill
        self.view.addSubview(completeAnimationView)
        
        completeAnimationView.play(completion: { finished in
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            self.completeAnimationView.removeFromSuperview()
        })
    }
}

extension CheckoutViewController :  CheckoutViewProtocol {
    func fetchAndUpdateTableView() -> Void {
        self.checkouted = presenter.listCheckouts()
        
        tvCheckout.reloadData()
    }
    
    func setupTableView(){
        tvCheckout.register(UICheckoutTableViewCell.nib, forCellReuseIdentifier: ReusableIds.Checkout.CHECKOUT_CELL)
    }
    
    func toggleNoCarLabel() {
        svCheckout.isHidden = !svCheckout.isHidden
        lbNoCar.isHidden = !lbNoCar.isHidden
    }
    
    func showPriceLimitExceeded(maxValue: Double) {
        showOkAlert(title: "Valor excedido", message: "O valor máximo permitido para compra é: \(maxValue)", callback: {
            return
        })
    }
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
        
        cell.onClickRemove.tag = checkout.car.id
        
        cell.onClickRemove.addTarget(self, action: #selector(onClickedRemove(_:)), for: .touchUpInside)
    }
    
    @objc func onClickedRemove(_ sender: UIButton){
        let carId = sender.tag
        
        presenter.removeCarFromList(id: carId)
        
        if checkouted.count == 0 {
            toggleNoCarLabel()
        }
    }
}
