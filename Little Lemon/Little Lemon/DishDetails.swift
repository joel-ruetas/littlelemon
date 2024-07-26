//
//  DishDetails.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-23.
//

import SwiftUI

struct DishDetails: View {
    let dish: Dish
    
    var body: some View {
        VStack {
            Text(dish.title ?? "Unknown Dish")
                .font(.custom("MarkaziText-Medium", size: 64))
                .fontWeight(.medium)
                .foregroundColor(Color("Primary 1"))
                .multilineTextAlignment(.center)
                .padding()
            
            if let description = dish.desc {
                Text(description)
                    .font(.custom("Karla", size: 18))
                    .fontWeight(.medium)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            Text("$\(dish.price, specifier: "%.2f")")
                .font(.custom("Karla", size: 20))
                .fontWeight(.bold)
                .padding()

            if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .padding()
                } placeholder: {
                    ProgressView()
                }
            }

            Spacer()
        }
        .navigationTitle(dish.title ?? "Dish Details")
        .padding()
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    dish.title = "Greek Salad"
    dish.price = 12.99
    dish.desc = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
    dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"
    return DishDetails(dish: dish)
}
