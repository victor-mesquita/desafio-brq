//
//  Constants.swift
//  CGShop
//
//  Created by mac on 18/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

struct ENV {
    struct API {
        static let BASE_URL = "http://desafiobrq.herokuapp.com/v1/"
    }
}


struct ErrorMessage {
    static let REQUEST_ERROR = "Failed to finish request!"
    static let JSON_DECODE_ERROR = "Failed to decode JSON string"
}

struct Segues {
    static let CAR_DETAIL_SEGUE = "carDetailSegue"
}

struct ReusableIds {
    struct CarList {
        static let PRODUCT_ITEM_CELL = "productitem"
    }
}
