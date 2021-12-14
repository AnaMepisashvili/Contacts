//
//  ModelManager.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 09.12.21.
//

import UIKit
import CoreData
import Contacts

protocol ModelManagerProtocol: BasePersistentProtocol {
    func getContactsFromCoreData(completion: @escaping (Result<[Contact], Error>) -> Void)
    
    init(with persistent: PersistentManagerProtocol)
}

final class ModelManager: ModelManagerProtocol {
    //MARK: - Properties
    
    var persistent: PersistentManagerProtocol!
    var modelObject: NSManagedObject? {
        guard let context = context else { return nil }
        guard let description = NSEntityDescription.entity(forEntityName: "Contact", in: context) else { return nil }
        let obj = NSManagedObject(entity: description, insertInto: context)
        return obj
    }
    // MARK: - Functions
    
    func addContactToCoreData(usingModel model: CNContact) {
        guard let context = context else { return }
        let model2 = Contact(context: context)
        model2.firstName = model.givenName
        model2.lastName = model.familyName
        model2.mobile = model.phoneNumbers.first?.value.stringValue
        do {
            try context.save()
        }
        
        catch {
            print(error)
        }
    }
    
    func updateCoreData(model: CNContact) {
        guard let context = context else { return }
        let contact = Contact(context: context)
        contact.firstName = model.givenName
        contact.lastName = model.familyName
        contact.mobile = model.phoneNumbers.first?.value.stringValue
        
        let fetchRequest:NSFetchRequest<Contact> = NSFetchRequest.init(entityName: "Contact")
        let predicate = NSCompoundPredicate(
            type: .and,
            subpredicates: [
                NSPredicate(format: "firstName = %@", "\(model.givenName)"),
                NSPredicate(format: "lastName = %@", "\(model.familyName)"),
                NSPredicate(format: "mobile = %@", "\(model.phoneNumbers.first?.value.stringValue)")
            ]
        )
        fetchRequest.predicate = predicate
        do {
            let object = try context.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object.first as! NSManagedObject
                objectUpdate.setValue(model.givenName, forKey: "firstName")
                objectUpdate.setValue(model.familyName, forKey: "lastName")
                objectUpdate.setValue(model.phoneNumbers.first?.value.stringValue, forKey: "mobile")
                do {
                    try context.save()
                } catch {
                    print(error)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func getContactsFromCoreData(completion: @escaping (Result<[Contact], Error>) -> Void) {
        guard let context = context else { return }
        do {
            let request = NSFetchRequest<Contact>(entityName: "Contact")
            let models = try context.fetch(request)
            
            completion(.success(models))
        } catch {
            print(error)
            completion(.failure(error))
        }
    }
    
    func clearContactsInCoreData() {
        guard let context = context else { return }
        let request = NSFetchRequest<Contact>(entityName: "Contact")
        do {
            let entities = try context.fetch(request)
            entities.forEach {
                context.delete($0)
            }
            try context.save()
        } catch {
            print(error)
        }
    }
    
    init(with persistent: PersistentManagerProtocol) {
        self.persistent = persistent
    }
}

