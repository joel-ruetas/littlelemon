//
//  DisplayDish.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-23.
//

import SwiftUI
import CoreData

// Define a new struct for a single dish row
struct DisplayDish: View {
    var dish: Dish

    var body: some View {
        NavigationLink(destination: DishDetails(dish: dish)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(dish.title ?? "")
                        .font(.custom("Karla", size: 18))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text(dish.desc ?? "")
                        .font(.custom("Karla", size: 16))
                        .foregroundColor(Color("Highlight 2"))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                    
                    Text("$\(dish.price, specifier: "%.2f")")
                        .font(.custom("Karla", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top)
                }
                
                Spacer()
                
                if let imageUrl = dish.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.shared.container.viewContext
    let dish = Dish(context: context)
    dish.title = "Greek Salad"
    dish.price = 12.99
    dish.desc = "The famous greek salad of crispy lettuce, peppers, olives, our Chicago."
    dish.image = "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"

    return NavigationView {
        DisplayDish(dish: dish)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
