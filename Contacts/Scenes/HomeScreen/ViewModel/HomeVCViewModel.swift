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
    var contacts =  [Contact(name: "Ana Gogia", image: "IMG_A", mobile: "+995 599 50 40 40", notes: "", email: ""),
                     Contact(name: "Ani Sikharulidze", image: "IMG_A", mobile: "+995 599 50 44 41", notes: "", email: ""),
                     Contact(name: "Ano Ghudushauri", image: "IMG_A", mobile: "+995 598 50 76 87", notes: "", email: ""),
                     Contact(name: "Bakhva Jakeli", image: "IMG_B", mobile: "+995 598 77 23 81", notes: "", email: ""),
                     Contact(name: "Beqa Gogokhia", image: "IMG_B", mobile: "+995 591 30 66 97", notes: "", email: ""),
                     Contact(name: "Daria Eristavi", image: "", mobile: "+995 598 00 86 86", notes: "", email: ""),
                     Contact(name: "Deda", image: "", mobile: "+995 578 60 23 37", notes: "", email: ""),
                     Contact(name: "Diana Pipinashvili", image: "", mobile: "+995 568 60 25 30", notes: "", email: ""),
                     Contact(name: "Ebo Qemoklidze", image: "", mobile: "+995 577 77 63 43", notes: "", email: ""),
                     Contact(name: "Giorgi Digmelashvili", image: "", mobile: "+995 599 07 20 67", notes: "", email: ""),
                     Contact(name: "Giorgi Dvali", image: "", mobile: "+995 598 55 45 40", notes: "", email: ""),
                     Contact(name: "Giorgi Gogava", image: "", mobile: "+995 599 65 43 37", notes: "", email: ""),
                     Contact(name: "Giorgi Gonjilashvili", image: "", mobile: "+995 599 78 35 76", notes: "", email: ""),
                     Contact(name: "Ia Sepiashvili", image: "", mobile: "+995 598 20 53 97", notes: "", email: ""),
                     Contact(name: "Ilia Malazonia", image: "", mobile: "+995 568 66 03 47", notes: "", email: ""),
                     Contact(name: "Irakli", image: "", mobile: "+995 568 60 25 30", notes: "", email: ""),
                     Contact(name: "Irina Gurgenidze", image: "", mobile: "+995 591 30 66 97", notes: "", email: ""),
                     Contact(name: "Juba(პერემიჩკები)", image: "", mobile: "+995 599 65 43 37", notes: "", email: ""),
                     Contact(name: "Keta Bulalauri", image: "", mobile: "+995 578 60 23 37", notes: "", email: ""),
                     Contact(name: "Kakha Arabidze", image: "", mobile: "+995 578 56 90 45", notes: "", email: ""),
                     Contact(name: "Lado Tsivtsivadze", image: "", mobile: "+995 599 65 43 37", notes: "", email: ""),
                     Contact(name: "Lasha Chantladze", image: "", mobile: "+995 591 30 66 97", notes: "", email: ""),
                     Contact(name: "Levan Xoxashvili", image: "", mobile: "+995 599 50 40 40", notes: "", email: ""),
                     Contact(name: "Ma", image: "", mobile: "+995 599 56 43 67", notes: "", email: ""),
                     Contact(name: "Mikheil Chikviladze", image: "", mobile: "+995 595 90 87 13", notes: "", email: ""),
                     Contact(name: "Natalia", image: "", mobile: "+995 599 99 80 99", notes: "", email: ""),
                     Contact(name: "Nikoloz Chanturia", image: "", mobile: "+995 599 76 53 36", notes: "", email: ""),
                     Contact(name: "Otar Khachapuridze", image: "", mobile: "+995 578 36 98 11", notes: "", email: ""),
                     Contact(name: "Pikinesa", image: "", mobile: "+995 597 24 54 56", notes: "", email: ""),
                     Contact(name: "Roko", image: "", mobile: "+995 598 45 76 56", notes: "", email: ""),
                     Contact(name: "Saba Dolaberidze", image: "+995 558 88 56 35", mobile: "", notes: "", email: ""),
                     Contact(name: "Tako Abramidze", image: "", mobile: "+995 585 48 36 73", notes: "", email: ""),
                     Contact(name: "Vika Pilpani", image: "", mobile: "+995 555 77 29 34", notes: "", email: ""),
                     Contact(name: "Zaza Mgaloblishvili", image: "", mobile: "+995 599 48 36 71", notes: "", email: ""),
                     Contact(name: "Giorgi Saakashvili", image: "", mobile: "+995 558 36 36 90", notes: "", email: "")
                     
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


