//
//  CustomerDetailViewModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation


final class CustomerDetailViewModel: ObservableObject {
    let customer: Customer
    
    init(customer: Customer) {
        self.customer = customer
    }
}

