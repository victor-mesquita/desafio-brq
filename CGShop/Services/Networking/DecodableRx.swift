//
//  DecodableRx.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Moya
import RxSwift
import SwiftyJSON

extension ObservableType where E == Response {
    func mapToModels<T: Decodable>(_: T.Type) -> Observable<[T]> {
        return self.mapJSON()
            .map { json -> [T] in
                guard let array = json as? [AnyObject] else {
                    throw ServiceError.wrongJSONParsing
                }
                return T.fromJSONArray(array)
        }
    }
    
    func mapToModels<T: Decodable>(_: T.Type, arrayRootKey: String) -> Observable<[T]> {
        return self.mapJSON()
            .map { json -> [T] in
                if let dict = json as? [String : AnyObject],
                    let subJson = dict[arrayRootKey] {
                    return T.fromJSONArray(subJson as! [AnyObject])
                } else {
                    throw ServiceError.wrongJSONParsing
                }
        }
    }
    
    func mapToModel<T: Decodable>(_: T.Type) -> Observable<T> {
        return self.mapJSON()
            .map { json -> T in
                return T.fromJSON(json as AnyObject)
        }
    }
}

private extension ObservableType where E == Response {
    func mapSwiftyJSON() -> Observable<JSON> {
        return self.mapJSON()
            .map { json in
                return JSON(json)
        }
    }
}
