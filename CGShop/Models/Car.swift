//
//  Car.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//
import Foundation

struct Car : Codable {
    let id: Int
    let nome: String
    let descricao: String?
    let marca: String
    let quantidade: Int
    let preco: Float
    let imagem: String
}
