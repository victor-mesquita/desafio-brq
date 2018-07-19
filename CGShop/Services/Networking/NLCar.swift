//
//  Car.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Alamofire

class NLCar {
    static func list(completion: @escaping (Result<[Car]>)->Void){
        Alamofire.request(CarRouter.list()).responseJSONDecodable{ (response: DataResponse<[Car]>) in
            completion(response.result)
        }
    }
}
