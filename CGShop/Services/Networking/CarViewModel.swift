//
//  CarViewModel.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CarViewModel {
    let nome: String
    let descricao: String
    let imagem: String
    let id: Int
    let preco: Float
    var carroIndisponivel: Bool = false
    
    init(car: Car) {
        self.nome = car.nome ?? ""
        self.descricao = car.descricao ?? ""
        self.imagem = car.imagem!
        self.id = car.id!
        self.preco = car.preco!
    }
    
    
}

extension Observable {
    func mapToCarViewModelArray() -> Observable<[CarViewModel]> {
        return self.map { cars in
            if let cars  = cars as? [Car] {
                return cars.map { return CarViewModel(car: $0) }
            } else {
                return []
            }
        }
    }
    
    func mapToCarViewModel() -> Observable<CarViewModel> {
        return self.map { car in
            if let car = car as? Car {
                var carViewModel = CarViewModel(car: car)
                
                if(carViewModel.id == 0)
                {
                    carViewModel.carroIndisponivel = true
                }
                
                return carViewModel;
            } else {
                return CarViewModel(car: Car(id: nil, nome: nil, descricao: nil, marca: nil, quantidade: nil, preco: nil, imagem: nil))
            }
        }
    }
}
