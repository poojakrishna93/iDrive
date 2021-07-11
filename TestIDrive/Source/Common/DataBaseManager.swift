//
//  DataBaseManager.swift
//  TestIDrive
//
//  Created by Pooja Krishna on 7/10/21.
//

import UIKit
import Realm
import RealmSwift
let myRealmQueue = DispatchQueue(label: "realmQueue", qos: .background)

class DataBaseManager {
    static let shared = DataBaseManager()
    private var realmReference: Realm?
    
    init() {
        do {
            realmReference = try Realm()
        } catch let error as NSError {
            debugPrint(error.debugDescription)
        }
    }

    func realmRef() -> Realm {
         return realmReference!
    }
    
    
    func configRealmForMigration() {
        var schemaVersion: UInt64 = 33
        if let buildNo = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            schemaVersion = UInt64(buildNo) ?? schemaVersion
        }
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: schemaVersion,

            // Set the block which will be called automatically when opening a Realm with
            // a schema versio n lower than the one set above
            migrationBlock: { _, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion > schemaVersion {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        debugPrint("Realm db path: ")
        debugPrint(config.fileURL ?? "")
    }

    class func migrte() {
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
    }
    
    /**
     Method to save menu list items
     */
    func saveMenuItems(_ items: MenuItemResponse?){
        guard nil != realmReference, let response = items else { return }
        do {
            try realmReference?.write {
                if let _ = cachedMenuResponse() {
                    // update old data from database
                    realmReference?.add(response, update: .all)
                    
                } else {
                    // Save the updated values to database
                    realmReference?.add(response)
                }
            }
        } catch _ {}
    }
    
    /*func getItems(from: Int, to:Int) -> List<MenuItem>?{
        //todo
    }*/
    
    /**
     Returns cached API profile response
     
     - returns: ProfileResponse
     */
    func cachedMenuResponse() -> MenuItemResponse? {
        return realmReference?.object(ofType: MenuItemResponse.self, forPrimaryKey: "1")
    }
    
    /**
     Method to save cart items
     */
    func saveToCart(item: MenuItem?) throws{
        guard nil != realmReference, let item = item else { return }
        do {
            try realmReference?.write {
                if let cartItems = cachedCartItems() {
                    // update old data from database
                    cartItems.itemsList.append(item)
                    realmReference?.add(cartItems, update: .all)
                } else {
                    // Save the updated values to database
                    let model = CartItemsResponse()
                    model.itemsList.append(item)
                    realmReference?.add(model)
                }
            }
        } catch _ {
            throw NSError(domain: "app.com", code: 1003, userInfo: [NSLocalizedDescriptionKey: ErrorMessageConstants.somethingWentWrong, NSLocalizedFailureReasonErrorKey: ""])
        }
    }
    
    /**
     Returns cached API profile response
     
     - returns: ProfileResponse
     */
    func cachedCartItems() -> CartItemsResponse? {
        return realmReference?.object(ofType: CartItemsResponse.self, forPrimaryKey: "1")
    }

}

