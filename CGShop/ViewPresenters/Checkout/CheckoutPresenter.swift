//
//  CheckoutPresenter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

protocol CheckoutPresenterProtocol {
    func persistCheckout(checkout: Checkout) -> Void
    func listCheckouts() -> [Checkout]
    func removeCarFromList(id: Int) -> Void
    func completePurchase() -> Void    
}

class CheckoutPresenter: BasePresenter<CheckoutViewController>, CheckoutPresenterProtocol
{
    let MAX_PURCHASE_LIMIT = 100000.00;
    static var checkoutDb = InMemoryDb<Checkout>()
    
    func persistCheckout(checkout: Checkout) -> Void {
        do {
            try CheckoutPresenter.checkoutDb.addOrUpdate(id: checkout.car.id, data: checkout)
        } catch  {
            return;
        }
    }
    
    func listCheckouts() -> [Checkout] {
        return CheckoutPresenter.checkoutDb.list()
    }
    
    func removeCarFromList(id: Int) {
        CheckoutPresenter.checkoutDb.remove(id: id)
        
        viewController?.fetchAndUpdateTableView()
    }
    
    private func isLimitValid(totalPrice: Double) -> Bool {
        return totalPrice <= MAX_PURCHASE_LIMIT;
    }
    
    func completePurchase() -> Void
    {
        let totalPrice = listCheckouts().map({ Float($0.amount) * $0.car.preco }).reduce(0.0, +)
        
        if isLimitValid(totalPrice: Double(totalPrice)) {
            CheckoutPresenter.checkoutDb = InMemoryDb<Checkout>()
            
            viewController?.fetchAndUpdateTableView()
            
            viewController?.showCompleteAnimation()
        }else{
            viewController?.showPriceLimitExceeded(maxValue: MAX_PURCHASE_LIMIT)
        }
    }
}
