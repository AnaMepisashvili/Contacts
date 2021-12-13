//
//  PersistentManager.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 09.12.21.
//

import Foundation
import UIKit
import CoreData

protocol PersistentManagerProtocol: BasePersistentProtocol {
    func create<T: NSManagedObject>(with object: T, completion: @escaping ((Bool) -> Void))
    func read<T: NSManagedObject>(with object: T, using predicate: NSPredicate?, completion: @escaping ((Bool) -> Void))
    func update<T>(with object: T, using predicate: NSPredicate?, completion: @escaping (Bool) -> Void) where T: NSManagedObject
}

final class PersistantManager: PersistentManagerProtocol {
    func create<T>(with object: T, completion: @escaping ((Bool) -> Void)) where T : NSManagedObject {
        guard let context = context else { return }
        
        do {
            try context.save()
        }
        catch {
            print(error)
        }
    }
    
    func read<T>(with object: T, using predicate: NSPredicate?, completion: @escaping ((Bool) -> Void)) where T : NSManagedObject {
        guard let context = context else { return }
        
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Contact")
            request.predicate = predicate
            let result = try context.fetch(request)
            completion(!result.isEmpty)
        }
        catch {
            print(error)
        }
    }
    
    func update<T>(with object: T, using predicate: NSPredicate?, completion: @escaping (Bool) -> Void) where T: NSManagedObject {
        guard let context = context else { return }
        
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "Contact")
            request.predicate = predicate
            let result = try context.fetch(request)
            
            if let newResult = result as? [Contact] {
                if newResult.count != 1 {
                    print("more than 1 users")
                }
                else {
                    try context.save()
                    completion(true)
                }
            }
        }
        catch {
            print(error)
        }
    }
}

