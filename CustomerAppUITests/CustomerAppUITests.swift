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
        
        
//        app.buttons["Add Customer"].tap()
//        
//        let nameFieldTextField = app/*@START_MENU_TOKEN@*/.textFields["NameField"]/*[[".otherElements",".textFields[\"Name\"]",".textFields[\"NameField\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        nameFieldTextField.tap()
//        
//        app.textFields["NameField"].tap()
//        nameFieldTextField.tap()
//        nameFieldTextField.typeText("UI Testing")
//        
//        let submitButton = app/*@START_MENU_TOKEN@*/.buttons["SubmitButton"]/*[[".otherElements",".buttons[\"Add Customer\"]",".buttons[\"SubmitButton\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        submitButton.tap()
//        
//        let emailFieldTextField = app/*@START_MENU_TOKEN@*/.textFields["EmailField"]/*[[".otherElements",".textFields[\"Email\"]",".textFields[\"EmailField\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        emailFieldTextField.tap()
//        emailFieldTextField.typeText("UITesting@")
//        submitButton.tap()
//        emailFieldTextField.typeText("gmail.com")
//        submitButton.tap()
//
//
//
//        app.staticTexts["Male"].tap()
//        let horizontalScrollBarElement = app/*@START_MENU_TOKEN@*/.otherElements["Horizontal scroll bar, 1 page"]/*[[".collectionViews.otherElements[\"Horizontal scroll bar, 1 page\"]",".otherElements[\"Horizontal scroll bar, 1 page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        horizontalScrollBarElement.tap()
//
//        app.staticTexts["Active"].tap()
//
//        
//
//
//        
//        submitButton.tap()
//        sleep(5)
//        
//        
//
//        let deleteStaticText = app.staticTexts["Delete"]
//        deleteStaticText.swipeLeft()
//        deleteStaticText.tap()
//        
//        let customersNavigationBar = app/*@START_MENU_TOKEN@*/.navigationBars["Customers"]/*[[".otherElements.navigationBars[\"Customers\"]",".navigationBars",".containing(.other, identifier: nil).firstMatch",".containing(.staticText, identifier: \"Customers\").firstMatch",".containing(.other, identifier: \"Add Customer\").firstMatch",".firstMatch",".navigationBars[\"Customers\"]"],[[[-1,6],[-1,1,1],[-1,0]],[[-1,5],[-1,4],[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/
//        customersNavigationBar.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["CustomerEmail_7947409"]/*[[".buttons[\"Aagneya Patil, patil_aagneya@murphy.example\"].staticTexts.firstMatch",".buttons",".staticTexts[\"patil_aagneya@murphy.example\"]",".staticTexts[\"CustomerEmail_7947409\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons.firstMatch",".otherElements.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.textFields["Aagneya Patil"]/*[[".otherElements",".textFields[\"Name\"]",".textFields[\"Aagneya Patil\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let patilAagneyaMurphyTextField = app/*@START_MENU_TOKEN@*/.textFields["patil_aagneya@murphy.example"]/*[[".otherElements",".textFields[\"Email\"]",".textFields[\"patil_aagneya@murphy.example\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
//        patilAagneyaMurphyTextField.tap()
//        patilAagneyaMurphyTextField.tap()
//        app/*@START_MENU_TOKEN@*/.textFields["patil_aagneya@murphy.exampl"]/*[[".otherElements",".textFields[\"Email\"]",".textFields[\"patil_aagneya@murphy.exampl\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let saveButton = app/*@START_MENU_TOKEN@*/.buttons["Save"]/*[[".otherElements[\"Save\"].buttons.firstMatch",".otherElements.buttons[\"Save\"]",".buttons[\"Save\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        saveButton.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Female"]/*[[".buttons[\"Gender, Female\"].staticTexts.firstMatch",".buttons.staticTexts[\"Female\"]",".staticTexts[\"Female\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Male"]/*[[".cells.buttons[\"Male\"]",".buttons[\"Male\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["Active"]/*[[".buttons[\"Status, Active\"].staticTexts.firstMatch",".buttons.staticTexts[\"Active\"]",".staticTexts[\"Active\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app/*@START_MENU_TOKEN@*/.otherElements["Horizontal scroll bar, 1 page"]/*[[".collectionViews.otherElements[\"Horizontal scroll bar, 1 page\"]",".otherElements[\"Horizontal scroll bar, 1 page\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        saveButton.tap()
//        app/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".navigationBars.buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        customersNavigationBar.swipeDown()
//        customersNavigationBar.swipeDown()
//        
//        let element = app.otherElements.element(boundBy: 3)
//        element/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
//        app/*@START_MENU_TOKEN@*/.staticTexts["Customers"]/*[[".navigationBars",".staticTexts.firstMatch",".staticTexts[\"Customers\"]"],[[[-1,2],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
//        element.swipeDown()
//        element.swipeDown()
        
        
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

        sleep(2)
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
        
        app/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".navigationBars.buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
 
    }

}
