//
//  Car.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//
import Foundation
import SwiftyJSON

struct Car {
    let id: Int?
    let nome: String?
    let descricao: String?
    let marca: String?
    let quantidade: Int?
    let preco: Float?
    let imagem: String?
}

extension Car : Decodable {
    static func fromJSON(_ json: AnyObject) -> Car {
        let json = JSON(json)
        
        let id = json["id"].intValue
        let nome = json["nome"].stringValue
        let descricao = json["descricao"].stringValue
        let marca = json["marca"].stringValue
        let quantidade = json["quntidade"].intValue
        let preco = json["preco"].floatValue
        let imagem = json["imagem"].stringValue
        
        
        return Car(id: id, nome: nome, descricao: descricao, marca: marca, quantidade: quantidade, preco: preco, imagem: imagem)
    }
}
