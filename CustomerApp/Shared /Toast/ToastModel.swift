//
//  ToastModel.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Foundation

struct Toast: Equatable {
  var style: ToastStyle
  var message: String
  var duration: Double = 3
  var width: Double = .infinity
}
