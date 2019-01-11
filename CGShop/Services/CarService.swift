//
//  File.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/10/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import RxSwift

class CarService : ServiceBase {
    static let bag = DisposeBag()
    static let jsonDecoder = JSONDecoder()
    
    
    static func listCars(callback: @escaping (Bool, [Car]?, String?) -> Void) {
        moyaProvider
            .rx
            .request(.listCars())
            .subscribe { event in
                switch event {
                case let .success(response):
                    
                    if response.statusCode == 200 {
                        do {
                            let cars = try jsonDecoder.decode([Car].self, from: response.data)
                            callback(true, cars , nil)
                        }catch{
                            callback(false, nil, ErrorMessage.JSON_DECODE_ERROR)
                        }
                        
                    }else{
                        callback(false, nil, ErrorMessage.REQUEST_ERROR)
                    }
                    
                case .error(_):
                    callback(false, nil, ErrorMessage.REQUEST_ERROR)
                }
            }
            .disposed(by: bag)
    }
    
    static func getCar(id: Int, callback: @escaping (Bool, Car?, String?) -> Void){
        moyaProvider
            .rx
            .request(.getCar(id: id))
            .subscribe { event in
                switch event {
                case let .success(response):
                    
                    if response.statusCode == 200 {
                        do {
                            let car = try jsonDecoder.decode(Car.self, from: response.data)
                            callback(true, car , nil)
                        }catch{
                            callback(false, nil, ErrorMessage.JSON_DECODE_ERROR)
                        }
                        
                    }else{
                        callback(false, nil, ErrorMessage.REQUEST_ERROR)
                    }
                    
                case .error(_):
                    callback(false, nil, ErrorMessage.REQUEST_ERROR)
                }
            }
            .disposed(by: bag)
    }
}
