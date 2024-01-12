//
//  mob_devApp.swift
//  mob_dev
//
//  Created by Sergei Pshonnov on 06.01.2024.
//

import SwiftUI

@main
struct mob_devApp: App {
    var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
