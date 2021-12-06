//
//  HomeVCModel.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 06.12.21.
//

import Foundation

protocol HomeVCViewModelProtocol {
    var contacts: [Contact] {get set}
    var sectionTitle: [String] {get set}
    var contactDict: [String: [String]] {get set}
    func getSectionTitle() -> [String]
}

class HomeVCViewModel: HomeVCViewModelProtocol {
    var contactDict = [String : [String]]()
    private var contactNames = [String]()
    var sectionTitle = [String]()
    var contacts =  [Contact(name: "Ana Gogia", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ani Sikharulidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ano Ghudushauri", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Bakhva Jakeli", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Beqa Gogokhia", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Daria Eristavi", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Deda", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Diana Pipinashvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ebo Qemoklidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Giorgi Digmelashvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Giorgi Dvali", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Giorgi Gogava", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Giorgi Gonjilashvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ia Sepiashvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ilia Malazonia", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Irakli", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Irina Gurgenidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Juba(პერემიჩკები)", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Keta Bulalauri", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Kakha Arabidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Lado Tsivtsivadze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Lasha Chantladze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Levan Xoxashvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Ma", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Mikheil Chikviladze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Natalia", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Nikoloz Chanturia", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Otar Khachapuridze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Pikinesa", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Roko", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Saba Dolaberidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Tako Abramidze", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Vika Pilpani", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Zaza Mgaloblishvili", image: "", mobile: "", notes: "", email: ""),
                     Contact(name: "Giorgi Saakashvili", image: "", mobile: "", notes: "", email: "")
                     
    ]
    
    func getSectionTitle() -> [String]{
        for contact in contacts {
            contactNames.append(contact.name)
        }
        sectionTitle = Array(Set(contactNames.compactMap({String($0.prefix(1))})))
        sectionTitle.sort()
        sectionTitle.forEach({contactDict[$0] = [String]()})
        contactNames.forEach({contactDict[String($0.prefix(1))]?.append($0)})
        return sectionTitle
    }
    
}
    

