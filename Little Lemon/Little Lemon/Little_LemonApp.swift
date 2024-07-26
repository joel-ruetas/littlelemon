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
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingView()
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            } else {
                NavigationView {
                    Onboarding()
                        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                }
            }
        }
    }
}
