//
//  BasePersistentProtocol.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 09.12.21.
//

import UIKit
import CoreData

// MARK: - Protocol

protocol BasePersistentProtocol: AnyObject {
    var context: NSManagedObjectContext? { get }
}
// MARK: - Extension

extension BasePersistentProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}
