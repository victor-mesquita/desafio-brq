//
//  Checkout.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

struct Checkout {
    init(amount: Int, car: Car) {
        self.amount = amount
        self.car = car
        
    }
    
    let amount: Int
    let car: Car
}
