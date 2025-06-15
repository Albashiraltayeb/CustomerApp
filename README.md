CustomerApp
A simple iOS application built with SwiftUI, demonstrating core CRUD (Create, Read, Update, Delete) operations for customer management, with integrated UI tests and a hybrid SwiftUI/UIKit list implementation.

Table of Contents
Features

Technologies Used

Getting Started

Prerequisites

Cloning the Repository

Opening in Xcode

Building and Running

Project Structure

Usage

Running UI Tests

Contributing

License

Features
Customer Listing: View a list of all customers.

Add Customer: Create new customer entries with name, email, gender, and status.

Customer Details: View and edit existing customer information.

Update Customer: Modify customer details.

Delete Customer: Remove customers from the list via swipe action.

Hybrid UI: Utilizes SwiftUI for the main list structure while integrating a custom UIKit UIView for individual list rows, demonstrating SwiftUI-UIKit interoperability.

Accessibility Identifiers: Thoroughly integrated for robust UI testing.

UI Tests: Comprehensive UI tests for core functionalities (add, edit, delete, navigation).

Offline Support: Fetches customer data from a network call and falls back to CoreData for offline persistence if no internet connection is available.

Technologies Used
SwiftUI: For declarative UI development of main views and app flow.

UIKit: For custom list row implementation (CustomerRowContentView) and underlying table view functionality via UIViewRepresentable.

CoreData: For local data persistence and offline support.

XCTest: For writing and running UI tests.

Xcode: The integrated development environment for Apple platforms.

Swift 5.x

Getting Started
Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

Prerequisites
Xcode 14.x or later

An iOS device or simulator running iOS 15.0 or later

Cloning the Repository
git clone https://github.com/your-username/CustomerApp.git
cd CustomerApp

Opening in Xcode
Open the CustomerApp.xcodeproj file in Xcode.

Building and Running
Select a simulator (e.g., iPhone 15 Pro) or a physical device as the run destination.

Click the "Run" button (▶️) in Xcode's toolbar or press Cmd + R.

The app should build and launch on your selected device/simulator.

Project Structure
Key files and folders in the project:

CustomerApp/: Main application source code.

App/: Contains CustomerAppApp (your main App entry point).

Data/: Handles data operations.

Networking/: Manages network calls.

APIManager.swift: Handles API requests.

APIManaging.swift: Protocol for API management.

NetworkError.swift: Custom network error definitions.

ValidationErrorResponseModel.swift: Model for handling API validation errors.

Persistence/: Manages local data storage using CoreData.

CustomerCacheService.swift: Service for caching customer data.

CustomerDataModel.swift: CoreData model definition.

PersistenceController.swift: CoreData stack setup and management.

Repositories/: Abstract layer for data access (concrete implementations).

DefaultCustomerRepository.swift: Concrete implementation of the customer repository.

Domain/: Defines business logic and interfaces for repositories.

Repositories/: Contains domain-specific repository protocols.

CustomerRepository.swift: Protocol defining customer data operations (e.g., fetch, save, delete).

Features/: Modularized feature modules.

AddCustomer/: Contains views and view models for adding customers.

AddCustomerView.swift

CustomerDetails/: Contains views and view models for customer details.

CustomerDetailView.swift

CustomerList/: Contains views and view models for the customer list.

CustomerListView.swift: The main customer list view (SwiftUI), which now uses CustomerRowRepresentable.

CustomerRowContentView.swift: Custom UIKit UIView for individual list rows.

CustomerRowContentView.xib: Interface Builder file for the CustomerRowContentView's layout.

CustomerRowRepresentable.swift: SwiftUI UIViewRepresentable to wrap CustomerRowContentView.

Resources/: Application resources like assets.

Assets.xcassets: Image and other assets.

Routing/: Manages navigation within the app.

NavigationRouter.swift: Handles navigation logic.

Shared/: Reusable UI components or common types.

Toast.swift: Custom toast message implementation.

Utilities/: Helper functions and extensions.

Extensions/: Swift extensions.

Helpers/: General helper functions.

Reachability.swift: For checking network connectivity.

ValidationErrorDecoder.swift: Decodes validation errors.

CustomerAppTests/: Unit testing bundle (if applicable).

CustomerAppUITests/: UI testing bundle.

CustomerListUITests.swift: Contains tests for the Customer List view (including add, delete, pull-to-refresh).

CustomerListUITests_AddCustomerFlow.swift: Dedicated tests for the Add Customer flow.

CustomerDetailViewUITests.swift: Contains tests for the Customer Detail view (including edit and save).

Usage
View Customers: The main screen displays a list of customers.

Add New Customer: Tap the + button in the navigation bar to add a new customer.

View/Edit Details: Tap on a customer row to view their details. Tap "Edit" to enable editing, then "Save" to commit changes.

Delete Customer: Swipe left on a customer row in the list and tap the "Delete" button.

Refresh List: Pull down on the customer list to refresh the data.

Offline Data: The app attempts to fetch data from the network first. If offline, it will display locally cached data from CoreData.

Running UI Tests
UI tests ensure the app's user interface functions as expected.

Select the Test Target: In Xcode, go to the Scheme selector (next to the play/stop buttons) and select CustomerAppUITests (or CustomerApp and then switch to the Test Navigator).

Open Test Navigator: Go to Navigator > Test (or Cmd + 6).

Run All Tests: Click the play button (▶️) next to the CustomerAppUITests target to run all UI tests.

Run Specific Tests: Click the play button (▶️) next to an individual test class or a specific test method within a class.

Important Notes for UI Tests:

UI tests interact with your app's live UI. Ensure your simulator/device screen is unlocked and visible during test execution.

For tests that involve existing data (like testDeleteCustomerSwipeAction or testCustomerDetailViewDisplaysCorrectly), ensure your app is launched with some initial customer data or implement test setup that populates data.

Contributing
Contributions are welcome! If you find a bug or have a feature request, please open an issue. If you'd like to contribute code, please fork the repository and create a pull request.

License
This project is licensed under the MIT License - see the LICENSE file for details.
