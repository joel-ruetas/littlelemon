//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-20.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            Onboarding().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
