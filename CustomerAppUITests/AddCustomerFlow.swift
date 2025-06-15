//
//  AddCustomerFlow.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import XCTest

class CustomerListUITests_AddCustomerFlow: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAddCustomerFlow() throws {
        let customerList = app.collectionViews["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list did not appear.")

        let addCustomerButton = app.buttons["Add Customer"]
        XCTAssertTrue(addCustomerButton.exists, "Add Customer button not found.")
        addCustomerButton.tap()

        let addCustomerNavigationView = app.navigationBars["Add Customer"]
        XCTAssertTrue(addCustomerNavigationView.waitForExistence(timeout: 5), "Add Customer view did not appear.")

        let nameTextField = app.textFields["NameField"]
        let emailTextField = app.textFields["EmailField"]
        let submitButton = app.buttons["SubmitButton"]

        XCTAssertTrue(nameTextField.exists, "Name text field not found (NameField).")
        XCTAssertTrue(emailTextField.exists, "Email text field not found (EmailField).")
        XCTAssertTrue(submitButton.exists, "Submit button not found (SubmitButton).")
        submitButton.tap()
        nameTextField.tap()
        nameTextField.typeText("New Customer Via UI Test")
        submitButton.tap()
        emailTextField.tap()
        emailTextField.typeText("uitest@")
        emailTextField.typeText("example.com")
        


                app.staticTexts["Male"].tap()
                let horizontalScrollBarElement = app/*@START_MENU_TOKEN@*/.otherElements["Horizontal scroll bar, 1 page"]/*[[".collectionViews.otherElements[\"Horizontal scroll bar, 1 page\"]",".otherElements[\"Horizontal scroll bar, 1 page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                horizontalScrollBarElement.tap()
        
                app.staticTexts["Active"].tap()

        submitButton.tap()


    }
}
