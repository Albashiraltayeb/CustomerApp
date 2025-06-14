//
//  CustomerCacheService.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//


import Foundation
import CoreData

class CustomerCacheService {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func saveCustomers(_ customers: [Customer]) throws {
        
        try clearData()

        for customer in customers {
            let entity = CustomerEntity(context: context)
            entity.id = Int64(customer.id)
            entity.name = customer.name
            entity.email = customer.email
            entity.gender = customer.gender
            entity.status = customer.status
        }

        try context.save()
    }

    func fetchCustomers() throws -> [Customer] {
        let fetchRequest: NSFetchRequest<CustomerEntity> = CustomerEntity.fetchRequest()
        let result = try context.fetch(fetchRequest)
        return result.map {
            Customer(id: Int($0.id),
                     name: $0.name ?? "",
                     email: $0.email ?? "",
                     gender: $0.gender ?? "",
                     status: $0.status ?? "")
        }
    }
    //delete data
    func clearData() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CustomerEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        try context.execute(deleteRequest)
    }
}
