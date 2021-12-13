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
    //func uploadModels(usingModel model: Model, completion: @escaping (Bool) -> Void)
    func getContactsFromCoreData(completion: @escaping (Result<[Contact], Error>) -> Void)
    
    init(with persistent: PersistentManagerProtocol)
    
}

final class ModelManager: ModelManagerProtocol {
    
    var persistent: PersistentManagerProtocol!
    
    var modelObject: NSManagedObject? {
        guard let context = context else { return nil }
        guard let description = NSEntityDescription.entity(forEntityName: "Contact", in: context) else { return nil }
        let obj = NSManagedObject(entity: description, insertInto: context)
        return obj
    }
    
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
    
    func isInCoreData(model: CNContact, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return }
        do {
            let request = NSFetchRequest<Contact>(entityName: "Contact")
            let models = try context.fetch(request)
            for contact in models {
                if contact.firstName == model.givenName && contact.lastName == model.familyName && contact.mobile == model.phoneNumbers.first?.value.stringValue {
                    completion(true)
                    return
                }
            }
            completion(false)
        } catch {
            print(error)
            return
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
        } catch {
            print(error)
        }
    }
    
    init(with persistent: PersistentManagerProtocol) {
        self.persistent = persistent
    }
    
}

