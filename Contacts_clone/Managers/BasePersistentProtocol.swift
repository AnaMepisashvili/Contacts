//
//  BasePersistentProtocol.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 09.12.21.
//

import UIKit
import CoreData

protocol BasePersistentProtocol: AnyObject {
    var context: NSManagedObjectContext? { get }
}

extension BasePersistentProtocol {
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
}
