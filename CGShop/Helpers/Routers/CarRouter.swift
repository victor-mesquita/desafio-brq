//
//  CarRouter.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Alamofire

enum CarRouter: APIConfiguration {
    
    case list()
    case car(id: Int)
    
    var method: HTTPMethod{
        switch self {
        case .car:
            return .get
        case .list:
            return .get
        }
    }

    var path: String{
        switch self {
        case .list:
            return "carro/"
        case .car(let id):
            return "carro/\(id)"
        }
    }
    
    var parameters: Parameters?{
        switch self {
        case .list:
            return nil
        case .car:
            return nil
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try ENV.API.BASE_URL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue;
        
        return urlRequest;
    }
    
    
}
