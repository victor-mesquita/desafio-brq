//
//  CarViewModel.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Foundation
import RxSwift

struct CarViewModel {
    let nome: String
    let descricao: String
    let imagem: String
    let id: Int
    let preco: Float
    
    init(car: Car) {
        self.nome = car.nome ?? ""
        self.descricao = car.descricao ?? ""
        self.imagem = car.imagem!
        self.id = car.id!
        self.preco = car.preco!
    }
}

extension Observable {
    func mapToCarViewModel() -> Observable<[CarViewModel]> {
        return self.map { cars in
            if let cars  = cars as? [Car] {
                return cars.map { return CarViewModel(car: $0) }
            } else {
                return []
            }
        }
    }
}
