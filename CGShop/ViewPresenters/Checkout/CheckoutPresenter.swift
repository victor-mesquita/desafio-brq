//
//  CheckoutPresenter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

class CheckoutPresenter: BasePresenter<CheckoutViewController> {
    static var checkoutDb = InMemoryDb<Checkout>()
    
    func persistCheckout(checkout: Checkout) -> Void {
        do {
            try CheckoutPresenter.checkoutDb.addOrUpdate(id: checkout.car.id, data: checkout)
        } catch  {
            return;
        }
    }
    
    func listCheckouts() -> [Checkout]{
        return CheckoutPresenter.checkoutDb.list()
    }
    
}
