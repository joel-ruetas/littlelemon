import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var menuItems: [MenuItem] = []
    @State private var searchText: String = ""
    @State private var selectedCategory: String? = nil
    @State private var isDataLoaded = false
    
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

            TextField("Search menu", text: $searchText)
                .padding()

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
                            .background(selectedCategory == category ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .cornerRadius(16)
                    }
                }
            }
            .padding()

            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        DisplayDish(dish: dish)
                    }
                }
            }
        }
        .onAppear {
            if !isDataLoaded {
                getMenuData()
                isDataLoaded = true
            }
        }
    }

    func getMenuData() {
        let persistenceController = PersistenceController.shared
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(MenuList.self, from: data)
                DispatchQueue.main.async {
                    self.menuItems = decodedData.menu
                    persistenceController.clear() // Clear Core Data only before saving new data
                    saveToCoreData(menuItems: decodedData.menu)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }

        task.resume()
    }
    
    func saveToCoreData(menuItems: [MenuItem]) {
        for item in menuItems {
            let dish = Dish(context: viewContext)
            dish.id = Int64(item.id)
            dish.title = item.title
            dish.desc = item.description
            dish.price = Float(item.price) ?? 0.0
            dish.image = item.image
            dish.category = item.category
        }

        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error)")
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))]
    }

    func buildPredicate() -> NSPredicate {
        var predicates = [NSPredicate]()
        
        if !searchText.isEmpty {
            predicates.append(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        }
        
        if let category = selectedCategory {
            predicates.append(NSPredicate(format: "category CONTAINS[cd] %@", category))
        }
        
        if predicates.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
    }
}

#Preview {
    Menu()
}
