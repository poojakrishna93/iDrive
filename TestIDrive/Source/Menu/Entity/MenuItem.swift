//
//  MenuItem.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/9/21.
//

import Foundation
import Realm
import RealmSwift

fileprivate class DummyCodable: Codable {}

extension UnkeyedDecodingContainer {

    public mutating func decodeArray<T>(_ type: T.Type) throws -> [T] where T : Decodable {

        var array = [T]()
        while !self.isAtEnd {
            do {
                let item = try self.decode(T.self)
                array.append(item)
            } catch let error {
                print("error: \(error)")

                // hack to increment currentIndex
                _ = try self.decode(DummyCodable.self)
            }
        }
        return array
    }
}

@objcMembers class MenuItem: Object, Decodable {
    dynamic var id: String = ""
    dynamic var name: String? = ""
    dynamic var image: String? = ""
    dynamic var desc: String? = ""
    dynamic var price: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case desc = "description"
        case price
    }
    
    required init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name)
        image = try container.decodeIfPresent(String.self, forKey: .image)
        desc = try container.decodeIfPresent(String.self, forKey: .desc)
        price = try container.decodeIfPresent(String.self, forKey: .price)
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

@objcMembers class MenuItemResponse: Object, Decodable {
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
