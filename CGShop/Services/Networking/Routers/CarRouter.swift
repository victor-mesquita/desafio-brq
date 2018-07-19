//
//  CarRouter.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Foundation
import Moya
import RxSwift


let CarProvider = MoyaProvider<CarRouter>(endpointClosure: endpointClosure)

public enum CarRouter {
    case list()
    case car(id: Int)
}

extension CarRouter : TargetType {
    public var task: Task {
        return .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var baseURL: URL {
        return URL(string: ENV.API.BASE_URL)!
    }
    
    public var path: String {
        switch self {
        case .list:
            return "/carro/"
        case .car(let id):
            return "/carro/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .list,
             .car(_):
            return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .car(_),
             .list:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }    
}

var endpointClosure = { (target: CarRouter) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
    
    return endpoint
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}
