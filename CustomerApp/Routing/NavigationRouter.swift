//
//  NavigationRouter.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//
import SwiftUI

enum Route: Hashable {
    case customerDetail(Customer)}

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func reset() {
        path.removeLast(path.count)
    }
}
