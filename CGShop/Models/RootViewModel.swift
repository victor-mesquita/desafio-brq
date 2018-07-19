//
//  RootViewModel.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
import Moya

class RootViewModel {
    
    var triggerRefresh = PublishSubject<Void>()

    var searchText = Variable("")
    let title = "Buscar";
    
    let carListResult: Driver<[CarViewModel]>
    
    fileprivate let provider: MoyaProvider<CarRouter>

    init() {
        self.provider = CarProvider
        
        carListResult = provider.rx.request(.list())
            .asObservable()
//            .mapJSON()
            .mapToModels(Car.self)
            .mapToCarViewModel()
            .asDriver(onErrorJustReturn: [])
    }
}
