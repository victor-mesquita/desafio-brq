//
//  BRQAPIService.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/10/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation
import Moya

let moyaProvider = MoyaProvider<BRQAPIService>()

enum BRQAPIService {
    case listCars()
    case getCar(id: Int)
}


extension BRQAPIService: TargetType {
    var task: Task {
        
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }
        
        return .requestPlain
        
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "Accept" : "application/json",
                "Content-Type" : "application/json"
            ]
        }
    }
    
    var baseURL : URL { return URL(string: ENV.API.BASE_URL)! }
    var path: String {
        switch self {
        case .getCar(let id):
            return "/carro/\(id)"
        case .listCars:
            return "/carro/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        
        return "{}".data(using: String.Encoding.utf8)!
    }
}

public func url(route: TargetType) -> String {
    let url = route.baseURL.appendingPathComponent(route.path).absoluteString
    
    return url
}
