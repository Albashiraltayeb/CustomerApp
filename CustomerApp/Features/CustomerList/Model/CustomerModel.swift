//
//  CustomerModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

struct Customer: Codable, Identifiable, Hashable {
    let id: Int
    var name: String
    var email: String
    var gender: String
    var status: String
}
