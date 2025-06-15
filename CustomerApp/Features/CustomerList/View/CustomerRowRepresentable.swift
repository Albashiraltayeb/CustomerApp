//
//  CustomerRowRepresentable.swift
//  CustomerApp
//
//  Created by mac air on 15/06/2025.
//

import SwiftUI
import UIKit

struct CustomerRowRepresentable: UIViewRepresentable {

    let customer: Customer
    func makeUIView(context: Context) -> CustomerRowContentView {
        let contentView = CustomerRowContentView()
        contentView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        contentView.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        return contentView
    }

    func updateUIView(_ uiView: CustomerRowContentView, context: Context) {
        uiView.configure(with: customer)
    }
}
