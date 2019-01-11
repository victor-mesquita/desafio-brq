//
//  CarListPresenter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/10/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

protocol CarListPresenterProtocol {
    func fetchCarList()
}

class CarListPresenter : BasePresenter<CarListViewController>, CarListPresenterProtocol {
    var carListSearchable: [Car] = [Car]();
    
    func fetchCarList() {
        self.viewController!.view.showLoading()
        
        CarService.listCars{ (success, cars, errorMessage) in
            if success {
                self.carListSearchable = cars!;
                self.viewController?.reloadCarList(cars: cars!)
            }
            
            self.viewController?.view.closeLoading()
        }
    }
    
    func searchCar(carName: String) -> Void {
        let immutableCarListSearchable = self.carListSearchable
        
        if(carName == "") {
            self.viewController?.reloadCarList(cars: immutableCarListSearchable)
            return
        }
        
        let filteredCarList = immutableCarListSearchable.filter({ $0.nome.contains(carName) })
        
        self.viewController?.reloadCarList(cars: filteredCarList)
    }
}
