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
    var searchText = BehaviorRelay(value: "")
    
    let result = BehaviorRelay<[CarViewModel]>(value: [CarViewModel]())
    
    let searchResult = BehaviorRelay<[CarViewModel]>(value: [CarViewModel]())
    
    fileprivate let provider: MoyaProvider<CarRouter>
    
    init(provider: MoyaProvider<CarRouter>) {
        self.provider = provider
        
        //TODO: Adicionado um loading
        
        _ = provider.rx.request(.list())
            .asObservable()
            .mapToModels(Car.self)
            .mapToCarViewModel()
            .bind(to: self.result)
        
        let searchTextObservable = searchText.asObservable()
        
        _ = searchTextObservable
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map{ query -> [CarViewModel] in
                let tempCars = self.result.value
                var filteredCars = [CarViewModel]()
                
                if !query.isEmpty{
                    filteredCars = tempCars.filter{
                        $0.nome.lowercased().contains(query.lowercased())
                    }
                }else {
                    filteredCars = tempCars
                }
                
                return filteredCars;
            }
            .bind(to: searchResult)
    }
}

