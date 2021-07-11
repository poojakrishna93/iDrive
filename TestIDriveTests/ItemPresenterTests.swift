//
//  ItemPresenterTests.swift
//  TestIDriveTests
//
//  Created by Pooja Krishna on 7/11/21.
//

import XCTest
@testable import TestIDrive

class ItemPresenterTests: XCTestCase {
    
    
    var presenter: ItemsPresenter?

    override func setUpWithError() throws {
        presenter = ItemsPresenter(interactor: ItemsInteractor(), router: ItemsRouter())
        
        let menu = MenuItemResponse()
        let item1 = MenuItem()
        item1.id = "1"
        item1.name = "abc"
        item1.price = "10"
        menu.itemsList.append(item1)
        
        let item2 = MenuItem()
        item2.id = "2"
        item2.name = "efg"
        item2.price = "15"
        menu.itemsList.append(item2)
        presenter?.didGetItems(success: true, items: menu, error: nil)
    }

    override func tearDownWithError() throws {
        
    }

    func testMenuItemsCount() {
        let count = presenter?.menuItemsCount()
        XCTAssertEqual(count, 2, "Count is not matching")
    }
    
    func testItemAtIndex() {
        let item = presenter?.itemAtIndex(1)
        XCTAssertNotNil(item, "item is nil")
        XCTAssertEqual(item?.id, "2", "Unexpected result")
        
        let item1 = presenter?.itemAtIndex(3)
        XCTAssertNil(item1, "Item expected to be nil")
    }
    
}


