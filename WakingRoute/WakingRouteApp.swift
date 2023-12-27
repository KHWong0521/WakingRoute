//
//  WakingRouteApp.swift
//  WakingRoute
//
//  Created by KwanHoWong on 28/12/2023.
//

import SwiftUI

@main
struct WakingRouteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
