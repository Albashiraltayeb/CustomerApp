//
//  CustomerAppUITests.swift
//  CustomerAppUITests
//
//  Created by mac air on 14/06/2025.
//

import XCTest


final class CustomerListViewTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func testCustomerListLoadsSuccessfully() {
        
        let app = XCUIApplication()
        app.activate()
        app.buttons["Add Customer"].tap()
        
        let nameFieldTextField = app/*@START_MENU_TOKEN@*/.textFields["NameField"]/*[[".otherElements",".textFields[\"Name\"]",".textFields[\"NameField\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        nameFieldTextField.tap()
        
        let submitButton = app/*@START_MENU_TOKEN@*/.buttons["SubmitButton"]/*[[".otherElements",".buttons[\"Add Customer\"]",".buttons[\"SubmitButton\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        submitButton.tap()
        
        let emailFieldTextField = app/*@START_MENU_TOKEN@*/.textFields["EmailField"]/*[[".otherElements",".textFields[\"Email\"]",".textFields[\"EmailField\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        emailFieldTextField.tap()
        emailFieldTextField.typeText("UITesting@")
        submitButton.tap()
        emailFieldTextField.typeText("gmail.com")
        submitButton.tap()

        app.textFields["NameField"].tap()
        nameFieldTextField.tap()
        nameFieldTextField.typeText("UI Testing")

        app.staticTexts["Male"].tap()
        let horizontalScrollBarElement = app/*@START_MENU_TOKEN@*/.otherElements["Horizontal scroll bar, 1 page"]/*[[".collectionViews.otherElements[\"Horizontal scroll bar, 1 page\"]",".otherElements[\"Horizontal scroll bar, 1 page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        horizontalScrollBarElement.tap()

        app.staticTexts["Active"].tap()

        


        
        submitButton.tap()

        
        
        
        
        
    }


}
