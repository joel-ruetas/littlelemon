//
//  NavigationBar.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-26.
//

import SwiftUI

struct NavigationBar: View {
    var body: some View {
        ZStack{
            HStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 40)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    NavigationBar()
}
