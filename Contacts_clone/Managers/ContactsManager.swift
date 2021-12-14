//
//  BasePersistentProtocol.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 09.12.21.
//

import Foundation
import Contacts

class ContactsManager: BasePersistentProtocol {
    static let shared = ContactsManager()
    
    //MARK: - Properties
    
    private init() {}
    
    var contactStore = CNContactStore()
    var contacts = [Contact]()
    var setContacts: (([Contact]) -> Void)?
    var coreDataManager: ModelManager = ModelManager(with: PersistantManager())
    
    // MARK: - Functions
    
    func handleAuthorizatignStatus() {
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Auth Success")
                self.loadContactsIntoCoreData()
            } else {
                print("error \(String(describing: error))")
            }
        }
    }
    
    private func getContacts(completion: @escaping ([Contact]) -> Void) {
        coreDataManager.getContactsFromCoreData { result in
            switch result {
            case .success(let data):
                let contacts = data.sorted { $0.firstName ?? "" < $1.firstName ?? "" }
                completion(contacts)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getHeaders(completion: @escaping ([String]) -> Void) {
        coreDataManager.getContactsFromCoreData { result in
            switch result {
            case .success(let data):
                let contacts = data.sorted { $0.firstName ?? "" < $1.firstName ?? "" }
                let alphas = contacts.compactMap {($0.firstName ?? "").first}
//                var alphas: [String] = []
//                contacts.forEach {
//                    if !$0.firstName!.startsWithAsciiLetter {
//                        alphas.append("#")
//                    }else{
//                        let resultString = String(($0.firstName ?? "").first!)
//                        alphas.append(resultString)
//                    }
//                }
                completion(Array(Set(alphas)).sorted().map { String($0) })
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func getDict(headers: [String], completion: @escaping ([String: [Contact]]) -> Void) {
        getContacts { contacts in
            var resultDict: [String: [Contact]] = [:]
            for header in headers {
                resultDict[header] = contacts.filter { ($0.firstName ?? "").first?.lowercased() == header.first?.lowercased() }
            }
            completion(resultDict)
        }
        
    }
    
    func loadContactsIntoCoreData()  {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) { [weak self] (contact, stoppingPointer) in
            
            self?.coreDataManager.updateCoreData(model: contact)
        }
    }
}


