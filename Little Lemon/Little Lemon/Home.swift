//
//  Home.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-21.
//

import SwiftUI

struct Home: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
                .tag(0)
            
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
                .tag(1)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
