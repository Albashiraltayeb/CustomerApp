//
//  CustomerAppUITests.swift
//  CustomerAppUITests
//
//  Created by mac air on 14/06/2025.
//

import XCTest


// MARK: - CustomerManagerUITests/CustomerListViewUITests.swift
import XCTest

// It's a good practice to have a separate UI test class for each major view or flow.
final class CustomerListViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Stop immediately when a failure occurs.
        continueAfterFailure = false

        // XCUIApplication is the proxy for your application under test.
        app = XCUIApplication()
        
        // Clear Core Data for fresh state in tests (requires app support via launch arguments)
        // In your main app, you'd need to listen for this launch argument and clear Core Data.
        app.launchArguments = ["--uitesting-clear-coredata"]

        // Launch the application.
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        // You might capture a screenshot on failure here for debugging.
        // let screenshot = XCUIScreen.main.screenshot()
        // let attachment = XCTAttachment(screenshot: screenshot)
        // attachment.name = "Screenshot-on-Failure"
        // attachment.lifetime = .deleteOnSuccess
        // add(attachment)
    }

    // MARK: - Initial State Tests

    func test_customerList_displaysLoadingState_onInitialLoad() throws {
        // Arrange: (App launched with default settings that should trigger initial data fetch)
        // Act: (No specific action needed, just wait for the UI to reflect state changes)
        
        // Assert: Verify the loading indicator appears
        let loadingIndicator = app.otherElements["LoadingView"] // Using accessibilityIdentifier
        // Use `XCTNSPredicateExpectation` for more robust waiting if the element is transient.
        let loadingExpectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: loadingIndicator)
        
        // Wait for the loading indicator to exist within the timeout
        let result = XCTWaiter.wait(for: [loadingExpectation], timeout: 5.0)
        XCTAssertEqual(result, .completed, "The loading indicator should be visible initially.")
        
        // Wait for loading to complete and ensure the loading indicator disappears
        let customerList = app.tables["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "The customer list should appear after loading.")
        
        // Now, assert that the loading indicator is no longer present
        XCTAssertFalse(loadingIndicator.exists, "The loading indicator should disappear after customers load.")
    }

    func test_customerList_displaysEmptyState_whenNoCustomers() throws {
        // Arrange: Launch app with a specific launch argument to simulate no customers from API/Core Data
        // (You would need to implement this mock behavior in your app's main entry or repository)
        app.launchArguments.append("--uitesting-empty-customers")
        app.launch() // Re-launch with the new argument

        // Act: (No specific action needed)
        
        // Assert: Verify the empty state message appears
        let emptyStateText = app.staticTexts["No customers available"] // Using accessibilityIdentifier
        XCTAssertTrue(emptyStateText.waitForExistence(timeout: 10), "The empty state text should be visible.")
        
        // Ensure loading indicator is not present
        XCTAssertFalse(app.otherElements["LoadingView"].exists, "Loading indicator should not be present in empty state.")
    }

    // MARK: - Customer Display Tests

    func test_customerList_displaysCustomersCorrectly() throws {
        // Arrange: (Assume app launches with some mock customer data via launch arguments or direct API access)
        // For actual testing, you'd mock the API to return specific customers here.
        // Example: app.launchArguments.append("--uitesting-mock-customers")
        
        let customerList = app.tables["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "The customer list should be present.")

        // Act: Scroll if needed (e.g., if many customers)
        // customerList.swipeUp()
        
        // Assert: Verify specific customer elements
        // Assuming a customer with ID 1 and name "Test User" exists from your mock data
        let customerName = app.staticTexts["CustomerName_1"]
        let customerEmail = app.staticTexts["CustomerEmail_1"]
        
        XCTAssertTrue(customerName.waitForExistence(timeout: 5), "Customer name should be visible.")
        XCTAssertTrue(customerEmail.waitForExistence(timeout: 5), "Customer email should be visible.")
        XCTAssertEqual(customerName.label, "Test User", "Customer name should match expected value.")
        XCTAssertEqual(customerEmail.label, "test@example.com", "Customer email should match expected value.")
    }

    // MARK: - Interaction Tests

    func test_pullToRefresh_updatesCustomerList() throws {
        // Arrange: Ensure initial customer data is loaded (could be empty or existing)
        let customerList = app.tables["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list should be present.")

        // Act: Perform pull-to-refresh
        let firstCell = customerList.cells.firstMatch
        let startCoord = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.0))
        let endCoord = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 5.0)) // Pull down significantly
        startCoord.press(forDuration: 0.1, thenDragTo: endCoord)
        
        // Assert: Verify loading indicator reappears briefly and then customers are updated
        let loadingIndicator = app.otherElements["LoadingView"]
        XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 5), "Loading indicator should appear on pull-to-refresh.")
        XCTAssertFalse(loadingIndicator.waitForExistence(timeout: 10), "Loading indicator should disappear after refresh.")
        
        // Further assertions here to verify that the data actually changed (if your mock supports it)
        // For example, if refreshing fetches more customers, check the new count or a new customer's presence.
    }
    
    func test_customerList_navigatesToDetailView() throws {
        // Arrange: Ensure a customer is available to tap
        let customerList = app.tables["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list should be present.")
        
        let firstCustomerCell = customerList.cells.firstMatch
        XCTAssertTrue(firstCustomerCell.waitForExistence(timeout: 5), "First customer cell should be visible.")

        // Act: Tap on the first customer to navigate to details
        firstCustomerCell.tap()

        // Assert: Verify the detail view is displayed by checking its navigation title or a unique element
        let detailNavigationTitle = app.navigationBars["Customer Details"] // Based on your DetailView code
        XCTAssertTrue(detailNavigationTitle.waitForExistence(timeout: 5), "Customer Detail View should be displayed.")
    }
    
    // MARK: - Error and Offline Tests

    func test_customerList_displaysErrorMessage_onAPIError() throws {
        // Arrange: Configure your app via launch arguments to return an API error on fetch
        // (You would need to implement this in your APIManager or Repository mock)
        app.launchArguments.append("--uitesting-simulate-api-error")
        app.launch() // Re-launch with the new argument

        // Act: (App will attempt to fetch customers on launch)
        
        // Assert: Verify the error message alert appears
        let alert = app.alerts["Notice"] // Default alert title
        XCTAssertTrue(alert.waitForExistence(timeout: 10), "Error alert should be displayed.")
        
        let errorMessageText = alert.staticTexts["Server error 500: No message provided."].exists // Based on generic error message
        XCTAssertTrue(errorMessageText, "Error message should be visible in the alert.")
        
        alert.buttons["OK"].tap() // Dismiss the alert
        XCTAssertFalse(alert.exists, "Alert should be dismissed.")
    }
    
    func test_customerList_displaysOfflineBanner_whenOffline() throws {
        // Arrange: Configure your app via launch arguments to simulate offline mode
        // (This would involve telling your Repository to report as offline)
        app.launchArguments.append("--uitesting-simulate-offline")
        app.launch() // Re-launch with the new argument

        // Act: (No specific action, banner should appear on launch if offline)

        // Assert: Verify the offline banner is visible
        let offlineBanner = app.staticTexts["Offline Mode: Showing Cached Data"]
        XCTAssertTrue(offlineBanner.waitForExistence(timeout: 10), "The offline banner should be visible.")
        
        // Verify that the customer list still loads (from cache)
        let customerList = app.tables["CustomerList"]
        XCTAssertTrue(customerList.waitForExistence(timeout: 10), "Customer list should still be displayed from cache when offline.")
    }
}
