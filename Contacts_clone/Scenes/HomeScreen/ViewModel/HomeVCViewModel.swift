//
//  HomeVCModel.swift
//  Contacts
//
//  Created by Ana Mepisashvili on 06.12.21.
//

import Contacts
import Foundation

protocol HomeVCViewModelProtocol {
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
        
    func getSectionTitle() -> [String]{
        return sectionTitle
    }
}



