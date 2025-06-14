//
//  ValidationErrorDecoder.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

func decodeValidationError(from data: Data) throws -> String {
    let errors = try JSONDecoder().decode([ValidationErrorResponse].self, from: data)
    return errors
        .map { "\($0.field.capitalized): \($0.message)" }
        .joined(separator: "\n")
}
