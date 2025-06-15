# CustomerApp

A simple iOS application built with SwiftUI, demonstrating core CRUD (Create, Read, Update, Delete) operations for customer management, with integrated UI tests and a hybrid SwiftUI/UIKit list implementation.

## Table of Contents

* [Features](#features)
* [Technologies Used](#technologies-used)
* [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Cloning the Repository](#cloning-the-repository)
    * [Opening in Xcode](#opening-in-xcode)
    * [Building and Running](#building-and-running)
* [Usage](#usage)
* [Running UI Tests](#running-ui-tests)

## Features

* **Customer Listing:** View a list of all customers.
* **Add Customer:** Create new customer entries with name, email, gender, and status.
* **Customer Details:** View and edit existing customer information.
* **Update Customer:** Modify customer details.
* **Delete Customer:** Remove customers from the list via swipe action.
* **Hybrid UI:** Utilizes SwiftUI for the main list structure while integrating a custom UIKit `UIView` for individual list rows, demonstrating SwiftUI-UIKit interoperability.
* **Accessibility Identifiers:** Thoroughly integrated for robust UI testing.
* **UI Tests:** Comprehensive UI tests for core functionalities (add, edit, delete, navigation).
* **Offline Support:** Fetches customer data from a network call and falls back to CoreData for offline persistence if no internet connection is available.

## Technologies Used

* **SwiftUI:** For declarative UI development of main views and app flow.
* **UIKit:** For custom list row implementation (`CustomerRowContentView`) and underlying table view functionality via `UIViewRepresentable`.
* **CoreData:** For local data persistence and offline support.
* **XCTest:** For writing and running UI tests.
* **Xcode:** The integrated development environment for Apple platforms.
* **Swift 5.x**

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Xcode 16.x or later
* An iOS device or simulator running iOS 17.6 or later


### Opening in Xcode

1. Open the `CustomerApp.xcodeproj` file in Xcode.


## Usage

* **View Customers:** The main screen displays a list of customers.
* **Add New Customer:** Tap the `+` button in the navigation bar to add a new customer.
* **View/Edit Details:** Tap on a customer row to view their details. Tap "Edit" to enable editing, then "Save" to commit changes.
* **Delete Customer:** Swipe left on a customer row in the list and tap the "Delete" button.
* **Refresh List:** Pull down on the customer list to refresh the data.
* **Offline Data:** The app attempts to fetch data from the network first. If offline, it will display locally cached data from CoreData.

## Running UI Tests

UI tests ensure the app's user interface functions as expected.

1. Select the Test Target: In Xcode, go to the Scheme selector (next to the play/stop buttons) and select `CustomerAppUITests` (or `CustomerApp` and then switch to the Test Navigator).
2. Open Test Navigator: Go to `Navigator > Test` (or `Cmd + 6`).
3. Run All Tests: Click the play button (▶️) next to the `CustomerAppUITests` target to run all UI tests.
4. Run Specific Tests: Click the play button (▶️) next to an individual test class or a specific test method within a class.

**Important Notes for UI Tests:**
* UI tests interact with your app's live UI. Ensure your simulator/device screen is unlocked and visible during test execution.
* For tests that involve existing data (like `testDeleteCustomerSwipeAction` or `testCustomerDetailViewDisplaysCorrectly`), ensure your app is launched with some initial customer data or implement test setup that populates data.

