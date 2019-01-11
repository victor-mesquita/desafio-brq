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
    
    func fetchCarDetail(id: Int) -> Void {
        if let viewController = self.viewController {
            viewController.showLoading()
            
            CarService.getCar(id: id, callback: {(success, data, errorMessage) in
                if success {
                    viewController.setupCarDetail(car: data!);
                } else {
                    viewController.dismiss(animated: true, completion: nil)
                    viewController.showUnavailableCarAlert()
                }
                
                viewController.hideLoading()
            })
        }
    }
}
