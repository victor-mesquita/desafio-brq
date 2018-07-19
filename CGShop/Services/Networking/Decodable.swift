//
//  Decodable.swift
//  CGShop
//
//  Created by mac on 19/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import Foundation

protocol Decodable {
    static func fromJSON(_ json: AnyObject) -> Self
}

extension Decodable {
    static func fromJSONArray(_ json: [AnyObject]) -> [Self] {
        return json.map { Self.fromJSON($0) }
    }
}
