//
//  CoreDataStackImp.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/20/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreData
import UIKit
public protocol CoreDataStack: class {
    // MARK: - Properities

    var container: NSPersistentContainer { get }
    var context: NSManagedObjectContext { get }

    // MARK: - Method

    func saveContext()
}

public final class CoreDataStackImp: NSObject {
    public static let shared = CoreDataStackImp()
    public var container: NSPersistentContainer {
        /// CoreData Context Name >> Weather
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                /// Replace this implementation with code to handle the error appropriately.
                /// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }

    public var context: NSManagedObjectContext {
        return container.viewContext
    }

    public func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                /// Replace this implementation with code to handle the error appropriately.
                /// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        }
    }
}

extension CoreDataStackImp: CoreDataStack {}
