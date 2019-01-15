//
//  CarDetailPresenter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/11/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import Lottie

protocol CarDetailPresenterProtocol {
    func fetchCarDetail(id: Int) -> Void
}

class CarDetailPresenter: BasePresenter<CarDetailViewController> {
    private var carCache: Car? = nil
    
    func fetchCarDetail(id: Int) -> Void {
        if let viewController = self.viewController {
            viewController.showLoading()
            
            CarService.getCar(id: id, callback: {(success, data, errorMessage) in
                if success {
                    self.carCache = data;
                    
                    viewController.setupCarDetail(car: self.carCache!);
                    viewController.loadableComplete()
                    
                } else {
                    viewController.dismiss(animated: true, completion: nil)
                    viewController.showUnavailableCarAlert()
                }
                
                viewController.hideLoading()
            })
        }
    }
    
    func proceedToCheckout(numberOfCars: Int) -> Checkout?
    {
        if numberOfCars == 0
        {
            viewController?.showZeroCarAlert()
            return nil
        }
        
        if let car = carCache {
            let checkout = Checkout(amount: numberOfCars, car: car)
            
            return checkout
        }
        
        return nil
    }
}
