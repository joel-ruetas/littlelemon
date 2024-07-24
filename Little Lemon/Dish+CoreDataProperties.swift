//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-22.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: Float
    @NSManaged public var image: String?
    @NSManaged public var category: String?

}

extension Dish : Identifiable {
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }
    
    static func with(title: String,
                     _ context: NSManagedObjectContext) -> Dish? {
        let request = Dish.request()
        let predicate = NSPredicate(format: "title == %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count > 0
            else { return nil }
            return results.first
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func delete(with title: String,
                       _ context: NSManagedObjectContext) -> Bool {
        let request = Dish.request()
        
        let predicate = NSPredicate(format: "title == %@", title)
        request.predicate = predicate
        
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count == 1,
                  let dish = results.first
            else {
                return false
            }
            context.delete(dish)
            return true
        } catch (let error){
            print(error.localizedDescription)
            return false
        }
    }
    
    class func deleteAll(_ context: NSManagedObjectContext) {
        let request = Dish.request()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            guard let persistentStoreCoordinator = context.persistentStoreCoordinator else { return }
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
            save(context)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func save(_ context: NSManagedObjectContext) {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    class func readAll(_ context:NSManagedObjectContext) -> [Dish]? {
        let request = Dish.request()
        do {
            guard let results = try context.fetch(request) as? [Dish],
                  results.count > 0 else { return nil }
            return results
        } catch (let error){
            print(error.localizedDescription)
            return nil
        }
    }
    
}
