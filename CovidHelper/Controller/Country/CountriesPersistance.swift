//
//  CountriesPersistance.swift
//  CovidHelper
//
//  Created by Raviteja on 15/05/21.
//

import Foundation


class CountriesPersistance: BaseAPI {
    var country: [Countrys]?
    var countryStored: [Countrys]?
    
    var countryDetails: [CountryCharts] = []
    
    func search(withText text: String) {
        country = countryStored
        country = country?.filter({$0.country?.lowercased().replacingOccurrences(of: " ", with: "").contains(text.lowercased().replacingOccurrences(of: " ", with: "")) ?? false}) ?? []
        
        if text == "" {
            country = countryStored
        }
    }
    
    func getCountriesList(completion: @escaping FinalSuccess) {
        let request = Request(url: (.BASE_URL, .countries), method: .get, headers: false)
        super.hitApi(requests: request) { [weak self] responseJson, message, responseCode in
            if responseCode == 1 {
                do {
                    let serializeData = try JSONSerialization.data(withJSONObject: responseJson, options: .prettyPrinted)
                    let decodedJson = try JSONDecoder().decode([Countrys].self, from: serializeData)
                    self?.country = decodedJson
                    self?.countryStored = decodedJson
                    completion(true , "Success")
                } catch {
                    completion(false , error.localizedDescription)
                }
                
            } else {
                completion(false , message ?? "")
            }
        }
    }
    
    func getCountriesDetails(withSlug slug: String, completion: @escaping FinalSuccess) {
        let calender = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let request = Request(url: (.BASE_URL, .details(slug, (calender?.getDateAccoringTo(format: .MAIN) ?? ""), Date().getDateAccoringTo(format: .MAIN))), method: .get, headers: false)
        super.hitApi(requests: request) { [weak self] responseJson, message, responseCode in
            if responseCode == 1 {
                do {
                    let serializeData = try JSONSerialization.data(withJSONObject: responseJson, options: .prettyPrinted)
                    let decodedJson = try JSONDecoder().decode([CountryCharts].self, from: serializeData)
                    self?.countryDetails = decodedJson
                    completion(true , "Success")
                } catch {
                    completion(false , error.localizedDescription)
                }
                
            } else {
                completion(false , message ?? "")
            }
        }
    }
}
