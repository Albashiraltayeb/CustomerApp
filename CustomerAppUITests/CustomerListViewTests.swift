//
//  CustomerAppUITests.swift
//  CustomerAppUITests
//
//  Created by mac air on 14/06/2025.
//

import XCTest


final class CustomerListViewTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {


        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()

    }
    
    override func tearDownWithError() throws {

        app = nil
    }

    func testCustomerListLoadsSuccessfully() {
        

        let customerList = app.collectionViews["CustomerList"]
                XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")
        
        XCTAssertTrue(customerList.cells.count > 0, "No customers displayed in the list.")
        
        
    }
    func testDeleteCustomerSwipeAction() throws {
        let customerList = app.collectionViews["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")

        let initialCustomerCount = customerList.cells.count
        XCTAssertTrue(initialCustomerCount > 0, "No customers to delete.")

        let firstCustomerCell = customerList.cells.firstMatch
        XCTAssertTrue(firstCustomerCell.exists, "First customer cell not found for deletion.")
        firstCustomerCell.swipeLeft()

        let deleteStaticText = app.staticTexts["Delete"]
        deleteStaticText.swipeLeft()
    }
    
    func testPullToRefresh() throws {
        let customerList = app.collectionViews["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")
        XCTAssertTrue(customerList.cells.count > 0, "No customers to refresh list.")

        let firstCustomerCell = customerList.cells.firstMatch
        XCTAssertTrue(firstCustomerCell.exists, "First customer cell not found.")

        let startPoint = firstCustomerCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))

        let endPoint = customerList.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.9))


        startPoint.press(forDuration: 0.5, thenDragTo: endPoint)

        XCTAssertTrue(customerList.exists, "Customer list is not present after refresh.")

    }
    
    func testCustomerDetailNavigation() throws {
        let customerList = app.collectionViews["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")
        XCTAssertTrue(customerList.cells.count > 0, "No customers to navigate to detail view.")

        let firstCustomerCell = customerList.cells.firstMatch
        XCTAssertTrue(firstCustomerCell.exists, "First customer cell not found.")
        firstCustomerCell.tap()

        let customerDetailNavigationBar = app.navigationBars["Customer Details"]
        
        XCTAssertTrue(customerDetailNavigationBar.waitForExistence(timeout: 5), "Customer Detail view did not appear.")

        XCTAssertTrue(customerDetailNavigationBar.exists, "Customer Details navigation bar not present.")
        
        app.buttons["Back"].tap()
 
    }

}
