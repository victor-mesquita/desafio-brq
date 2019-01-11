//
//  BasePresenter.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/10/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import UIKit

protocol Presenter {
    associatedtype ViewController
    func attachToView(viewController: ViewController)
}


class BasePresenter<ViewController: UIViewController> : Presenter {
    var viewController: ViewController? = nil
    
    func attachToView(viewController: ViewController) {
        self.viewController = viewController
    }
}
