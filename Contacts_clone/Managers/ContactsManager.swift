//
//  ContactsManager.swift
//  Contacts_clone
//
//  Created by Ana Mepisashvili on 08.12.21.
//

import Foundation
import Contacts

class ContactsManager {
    static let shared = ContactsManager()
    
    private init() {}
    
    var contactStore = CNContactStore()
    var contacts = [Contact]()
    var setContacts: (([Contact]) -> Void)?
        
    func handleAuthorizatignStatus() {
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Auth Success")
                self.fetchContacts()
            } else {
                print("error \(String(describing: error))")
            }
        }
    }
    
    private func getContacts() -> [Contact] {
        let contacts = fetchContacts().sorted { $0.firstName < $1.firstName }
        return contacts
    }
    
    func getHeaders() -> [String] {
        let contacts = fetchContacts().sorted { $0.firstName < $1.firstName }
        let alphas = contacts.compactMap { $0.firstName.first }
        return Array(Set(alphas)).sorted().map { String($0) }
    }
    
    func getDict(headers: [String]) -> [String: [Contact]] {
        var resultDict: [String: [Contact]] = [:]
        for header in headers {
            resultDict[header] = getContacts().filter { $0.firstName.first == header.first }
        }
        return resultDict
    }
    
    func fetchContacts() -> [Contact] {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        var result: [Contact] = []
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            let contactToAppend = Contact(firstName: name, lastName: familyName, image: "", mobile: number ?? "")
            result.append(contactToAppend)
        }
//        setContacts?(contacts)
        return result
    }
}
