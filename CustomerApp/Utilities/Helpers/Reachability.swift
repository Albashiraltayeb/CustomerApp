//
//  Reachability.swift
//  CustomerApp
//
//  Created by mac air on 14/06/2025.
//

import Network

final class Reachability {
    static let shared = Reachability()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")
    
#if DEBUG
    var isConnected: Bool = true
#else
    private(set) var isConnected: Bool = true
#endif

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
