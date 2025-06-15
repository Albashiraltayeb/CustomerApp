//
//  CustomerDetailViewUITests.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import XCTest

class CustomerDetailViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testCustomerDetailViewDisplaysCorrectly() throws {

        let customerList = app.collectionViews["CustomerList"]
                XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")
        
        XCTAssertTrue(customerList.cells.count > 0, "No customers displayed in the list.")

        let firstCustomerCell = customerList.cells.firstMatch
        XCTAssertTrue(firstCustomerCell.exists, "First customer cell not found in the list.")
        firstCustomerCell.tap()

        let customerDetailNavigationBar = app.navigationBars["Customer Details"]
        XCTAssertTrue(customerDetailNavigationBar.waitForExistence(timeout: 5), "Customer Detail view navigation bar did not appear.")

        let nameTextField = app.textFields["NameTextField_Detail"]
        let emailTextField = app.textFields["EmailTextField_Detail"]
        let editButton = app.buttons["EditButton"]

        XCTAssertTrue(nameTextField.exists, "Name  not found in detail view.")
        
        XCTAssertTrue(emailTextField.exists, "Email not found in detail view.")
        
      
        XCTAssertTrue(editButton.exists, "Edit button not found in detail view.")

        XCTAssertFalse(nameTextField.isEnabled, "Name text field should be disabled initially.")
        
        XCTAssertFalse(emailTextField.isEnabled, "Email text field should be disabled initially.")
    }

    func testEditAndSaveCustomerDetails() throws {

        let customerList = app.collectionViews["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")
        XCTAssertTrue(customerList.cells.count > 0, "No customers to test editing. Ensure app has data.")
        customerList.cells.firstMatch.tap()

        let customerDetailNavigationBar = app.navigationBars["Customer Details"]
        XCTAssertTrue(customerDetailNavigationBar.waitForExistence(timeout: 5), "Customer Detail view did not appear.")

        let nameTextField = app.textFields["NameTextField_Detail"]
        let emailTextField = app.textFields["EmailTextField_Detail"]
        let editButton = app.buttons["EditButton"]
        
        let saveButton = app.buttons["SaveButton"]

        editButton.tap()

        XCTAssertTrue(nameTextField.isEnabled, "Name text field should be enabled after tapping Edit.")
        XCTAssertTrue(emailTextField.isEnabled, "Email text field should be enabled after tapping Edit.")
        XCTAssertTrue(saveButton.waitForExistence(timeout: 2), "Save button did not appear after tapping Edit.")
        XCTAssertFalse(editButton.exists, "Edit button should disappear after tapping Edit (as Save button takes its place).")

        let originalName = nameTextField.value as? String ?? ""
        let updatedName = "Updated " + originalName + UUID().uuidString.prefix(4)

        nameTextField.clearAndType(text: updatedName)
        emailTextField.clearAndType(text: "updated.email.test@example.com")

//        app.staticTexts["Male"].tap()
//        let horizontalScrollBarElement = app/*@START_MENU_TOKEN@*/.otherElements["Horizontal scroll bar, 1 page"]/*[[".collectionViews.otherElements[\"Horizontal scroll bar, 1 page\"]",".otherElements[\"Horizontal scroll bar, 1 page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        horizontalScrollBarElement.tap()

        saveButton.tap()

        XCTAssertTrue(editButton.waitForExistence(timeout: 2), "Edit button did not reappear after saving.")
        XCTAssertFalse(saveButton.exists, "Save button should disappear after saving.")

        app.buttons["Back"].tap()
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not reappear after navigating back from detail view.")
    }
}

extension XCUIElement {
    func clearAndType(text: String) {
        guard let stringValue = value as? String else {
            XCTFail("Tried to clear and type text into a non-textual element")
            return
        }

        tap()
        if !stringValue.isEmpty {
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            typeText(deleteString)
        }
    typeText(text)
    }
}
