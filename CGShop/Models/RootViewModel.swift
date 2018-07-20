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

    var searchText = BehaviorRelay(value: "")
    let title = "Buscar";
    
    var carListResult: Driver<[CarViewModel]>
    
    var carListResultRefresh: Driver<[CarViewModel]>
    
    fileprivate let provider: MoyaProvider<CarRouter>

    init(provider: MoyaProvider<CarRouter>) {
        self.provider = provider
        
        carListResult = provider.rx.request(.list())
            .asObservable()
//            .mapJSON()
            .mapToModels(Car.self)
            .mapToCarViewModel()
            .asDriver(onErrorJustReturn: [])
    
        carListResultRefresh = triggerRefresh.startWith(())
            .flatMapLatest {
                provider.rx.request(.list())
                    .retry(3)
                    .observeOn(MainScheduler.instance)
            }
            .mapJSON()
            .mapToCarViewModel()
            .asDriver(onErrorJustReturn: [])
    }
}

