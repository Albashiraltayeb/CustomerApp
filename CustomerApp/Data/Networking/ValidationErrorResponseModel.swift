//
//  ValidationErrorResponseModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

struct ValidationErrorResponse: Decodable {
    let field: String
    let message: String
}
