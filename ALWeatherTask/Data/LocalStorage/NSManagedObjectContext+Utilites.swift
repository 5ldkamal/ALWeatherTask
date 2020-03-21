//
//  NSManagedObjectContext+Utilites.swift
//  ALWeatherTask
//
//  Created by Khaled kamal on 3/21/20.
//  Copyright © 2020 Khaled kamal. All rights reserved.
//

import CoreData
import UIKit

// MARK: - Additions Functionalities

public protocol NSManagedObjectContextProtocol {
    func allEntities<T: NSManagedObject>(withType type: T.Type) throws -> [T]
    func allEntities<T: NSManagedObject>(withType type: T.Type, predicate: NSPredicate?) throws -> [T]
    func addEntity<T: NSManagedObject>(withType type: T.Type) -> T?
    
    func save() throws
    func delete(_ object: NSManagedObject)
}

extension NSManagedObjectContext: NSManagedObjectContextProtocol {
    ///
    public func allEntities<T>(withType type: T.Type) throws -> [T] where T: NSManagedObject {
        try allEntities(withType: type, predicate: nil)
    }

    ///
    public func allEntities<T>(withType type: T.Type, predicate: NSPredicate?) throws -> [T] where T: NSManagedObject {
        let entityName = T.description()
        let requst = NSFetchRequest<T>.init(entityName: entityName)
        requst.predicate = predicate

        let results = try self.fetch(requst)
        return results
    }

    ///
    public func addEntity<T>(withType type: T.Type) -> T? where T: NSManagedObject {
        let entityName = T.description()
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: self) else {
            return nil
        }
        let record = T(entity: entity, insertInto: self)
        return record
    }
}
