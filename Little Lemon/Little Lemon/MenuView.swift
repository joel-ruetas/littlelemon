//
//  MenuView.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-26.
//

import SwiftUI

struct MenuView: View {
    @Binding var selectedCategory: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Order for Delivery")
                    .font(.custom("Karla", size: 20))
                    .fontWeight(.bold)
                    .textCase(.uppercase)
                                
                Image("Delivery van")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .padding(.leading)
                
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)

            HStack {
                ForEach(["Starters", "Mains", "Desserts", "Drinks"], id: \.self) { category in
                    Button(action: {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                    }) {
                        Text(category)
                            .padding(10)
                            .background(selectedCategory == category ? Color("Secondary 1") : Color("Highlight 1"))
                            .foregroundColor(selectedCategory == category ? Color("Highlight 1") : Color("Highlight 2"))
                            .font(.custom("Karla", size: 16))
                            .fontWeight(.bold)
                            .cornerRadius(16)
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}

#Preview {
    MenuView(selectedCategory: .constant(nil))
}
