//
//  CoreDataManager.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
        persistentContainer = NSPersistentContainer(name: "NewsModel")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error al cargar Core Data: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error al guardar en Core Data: \(error)")
        }
    }
}
