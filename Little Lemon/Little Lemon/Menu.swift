//
//  Menu.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-21.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
            Text("Little Lemon Restaurant")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("Chicago")
                .font(.title)
                .padding()

            Text("Little Lemon is a charming neighborhood bistro that serves simple food and classic cocktails in a lively but casual environment. The restaurant features a locally-sourced menu with daily specials.")
                .font(.subheadline)
                .padding()

            List {
            }
        }
    }
}

#Preview {
    Menu()
}
