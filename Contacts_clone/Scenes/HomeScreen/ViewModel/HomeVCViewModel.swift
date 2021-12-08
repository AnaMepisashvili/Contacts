//
//  HomeVCModel.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 06.12.21.
//

import Contacts
import Foundation

protocol HomeVCViewModelProtocol {
    var contacts: [Contact] {get set}
    var contactsDict: [String: Contact] {get set}
    var sectionTitle: [String] {get set}
    var contactDict: [String: [String]] {get set}
    
    func getSectionTitle() -> [String]
}

class HomeVCViewModel: HomeVCViewModelProtocol {
    
    var contactDict = [String : [String]]()
    private var contactNames = [String]()
    var sectionTitle = [String]()
    var contactsDict = [String: Contact]()
//    var reloadTableView: (()->())?
    
    var contacts =  [Contact(firstName: "Ana", lastName: "Gogia", image: "", mobile: "+995 599 50 40 40"),
                     Contact(firstName: "Ani", lastName: "Sikharulidze", image: "", mobile: "+995 599 50 44 41"),
                     Contact(firstName: "Ano", lastName: "Ghudushauri", image: "", mobile: "+995 598 50 76 87"),
                     Contact(firstName: "Bakhva", lastName: "Jakeli", image: "", mobile: "+995 598 77 23 81"),
                     Contact(firstName: "Beqa", lastName: "Gogokhia", image: "", mobile: "+995 591 30 66 97"),
                     Contact(firstName: "Daria", lastName: "Eristavi", image: "", mobile: "+995 598 00 86 86"),
                     Contact(firstName: "Deda", lastName: "", image: "", mobile: "+995 578 60 23 37"),
                     Contact(firstName: "Diana", lastName: "Pipinashvili", image: "", mobile: "+995 568 60 25 30"),
                     Contact(firstName: "Ebo", lastName: "Qemoklidze", image: "", mobile: "+995 577 77 63 43"),
                     Contact(firstName: "Giorgi", lastName: "Gogava", image: "", mobile: "+995 599 65 43 37"),
                     Contact(firstName: "Giorgi", lastName: "Gonjilashvili", image: "", mobile: "+995 599 78 35 76"),
                     Contact(firstName: "Giorgi", lastName: "Saakashvili", image: "", mobile: "+995 558 36 36 90"),
                     Contact(firstName: "Ia", lastName: "Sepiashvili", image: "", mobile: "+995 598 20 53 97"),
                     Contact(firstName: "Ilia", lastName: "Malazonia", image: "", mobile: "+995 568 66 03 47"),
                     Contact(firstName: "Irakli", lastName: "", image: "", mobile: "+995 568 60 25 30"),
                     Contact(firstName: "Juba(პერემიჩკები)", lastName: "", image: "", mobile: "+995 599 65 43 35"),
                     Contact(firstName: "Keta", lastName: "Bulalauri", image: "", mobile: "+995 578 60 23 37"),
                     Contact(firstName: "Kakha", lastName: "Arabidze", image: "", mobile: "+995 578 56 90 45"),
                     Contact(firstName: "Lado", lastName: "Tsivtsivadze", image: "", mobile: "+995 599 65 43 37"),
                     Contact(firstName: "Lasha", lastName: "Chantladze", image: "", mobile: "+995 591 30 66 97"),
                     Contact(firstName: "Levan", lastName: "Xoxashvili", image: "", mobile: "+995 599 50 40 40"),
                     Contact(firstName: "Ma", lastName: "", image: "", mobile: "+995 599 56 43 67"),
                     Contact(firstName: "Mikheil", lastName: "Chikviladze", image: "", mobile: "+995 595 90 87 13"),
                     Contact(firstName: "Natalia", lastName: "", image: "",  mobile: "+995 599 99 80 99"),
                     Contact(firstName: "Otar", lastName: "Khachapuridze", image: "", mobile: "+995 578 36 98 11"),
                     Contact(firstName: "Pikinesa", lastName: "", image: "", mobile: "+995 597 24 54 56"),
                     Contact(firstName: "Roko", lastName: "", image: "", mobile: "+995 598 45 76 56"),
                     Contact(firstName: "Saba", lastName: "Dolaberidze", image: "", mobile: "+995 558 88 56 32"),
                     Contact(firstName: "Tako", lastName: "Abramidze", image: "", mobile: "+995 585 48 36 73"),
                     Contact(firstName: "Vika", lastName: "Pilpani", image: "", mobile: "+995 555 77 29 34"),
                     Contact(firstName: "Zaza", lastName: "Mgaloblishvili", image: "", mobile: "+995 599 48 36 71")
    ]
    
    func getSectionTitle() -> [String]{
        ContactsManager.shared.setContacts = { contacts in
            for contact in contacts {
                        self.contactNames.append(contact.firstName)
                        }
                        self.sectionTitle = Array(Set(self.contactNames.compactMap({String($0.prefix(1))})))
                        self.sectionTitle.sort()
                        self.sectionTitle.forEach({self.contactDict[$0] = [String]()})
                        self.contactNames.forEach({self.contactDict[String($0.prefix(1))]?.append($0)})
        }
//        contactNames = ContactsManager.shared.fetchContacts().map {
//            return $0.firstName
//        }
//        sectionTitle = Array(Set(contactNames.compactMap({String($0.prefix(1))})))

//        contacts.forEach{contactsDict[$0.firstName] = $0}
//        self.reloadTableView?()
        return sectionTitle
    }
}


