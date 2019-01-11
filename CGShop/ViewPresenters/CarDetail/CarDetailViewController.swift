//
//  CarDetailViewController.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

protocol CarDetailViewProtocol {
    func setupCarDetail(car: Car)
    func showUnavailableCarAlert()
}

class CarDetailViewController : BaseViewController {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var lbCarPrice: UILabel!
    @IBOutlet weak var lbCarName: UILabel!
    @IBOutlet weak var lbContentDescrition: UILabel!
    
    var presenter = CarDetailPresenter()
    var carId: Int = 0;
    
    @IBAction func onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.attachToView(viewController: self)
        
        presenter.fetchCarDetail(id: carId)
    }
}

// MARK - CarDetail Protocol
extension CarDetailViewController : CarDetailViewProtocol {
    
    func setupCarDetail(car: Car) {
        lbCarName.text = car.nome
        lbCarPrice.text = "R$ \(car.preco)"
        lbContentDescrition.text = car.descricao
    }
    
    func showUnavailableCarAlert() {
        let alert = UIAlertController(title: "Carro indisponível", message: "O carro selecionado não está disponível para compra!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
