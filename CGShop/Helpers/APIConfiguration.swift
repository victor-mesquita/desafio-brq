//
//  APIConfiguration.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
