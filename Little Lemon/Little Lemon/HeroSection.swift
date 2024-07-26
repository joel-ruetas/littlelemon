//
//  HeroSection.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-26.
//

import SwiftUI

struct HeroSection: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            Color("Primary 1").edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading, spacing: 1) {
                    Text("Little lemon")
                        .font(.custom("Markazi", size: 64))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Primary 2"))
                                        
                    HStack(alignment: .top, spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Chicago")
                                .font(.custom("Markazi", size: 40))
                                .foregroundColor(.white)
                                .padding(.bottom)

                            Text("We are a family owned Mediterranean restraunt, focused on traditional recipes with a modern twist.")
                                .font(.custom("Karla", size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Image("Hero image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 175)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                
                TextField("Search menu", text: $searchText)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    HeroSection(searchText: .constant(""))
}
