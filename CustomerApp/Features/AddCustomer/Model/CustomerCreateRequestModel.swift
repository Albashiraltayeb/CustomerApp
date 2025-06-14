//
//  CustomerCreateRequestModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

struct CustomerCreateRequest: Codable {
    let name: String
    let email: String
    let gender: String
    let status: String
}
