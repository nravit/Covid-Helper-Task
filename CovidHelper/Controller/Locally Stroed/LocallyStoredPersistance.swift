//
//  LocallyStoredPersistance.swift
//  CovidHelper
//
//  Created by Raviteja on 16/05/21.
//

import Foundation

class LocallyStoredPersistance {
    var country: [Country]?
    var countryStored: [Country]?
    
    
    func fetchFromCoreData(completion: @escaping FinalSuccess) {
        let fetchRequest = Country.fetchRequests()
        do {
            let data = try CoreDataDataHelper.instance?.mainContaxt.fetch(fetchRequest)
            self.country = data ?? []
            self.countryStored = data ?? []
            completion(true , "Success")
        } catch {
            completion(false , error.localizedDescription)
        }
    }
    
    func search(withText text: String) {
        country = countryStored
        country = country?.filter({$0.country?.lowercased().replacingOccurrences(of: " ", with: "").contains(text.lowercased().replacingOccurrences(of: " ", with: "")) ?? false}) ?? []
        
        if text == "" {
            country = countryStored
        }
    }
}
