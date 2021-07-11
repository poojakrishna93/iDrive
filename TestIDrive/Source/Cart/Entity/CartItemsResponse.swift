//
//  CartItemsResponse.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/11/21.
//

import Foundation
import RealmSwift

@objcMembers class CartItemsResponse: Object, Decodable {
    dynamic var itemsList = List<MenuItem>()
    dynamic var id: String = "1"
    
    required init(from decoder: Decoder) throws
    {
        var container = try decoder.unkeyedContainer()
        let itemArray = try container.decodeArray(MenuItem.self)
        id = "1"
        itemsList.append(objectsIn: itemArray)
        super.init()
    }
    
    override static func primaryKey() -> String?
    {
        return "id"
    }
    
    required override init()
    {
        super.init()
    }
    
}
